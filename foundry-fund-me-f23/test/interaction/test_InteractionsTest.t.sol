// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe} from "../../script/Interactions.s.sol";

contract TestInteractionsTest is Test {
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    FundMe fundMe;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        vm.startPrank(USER);
        FundFundMe fundFundMe = new FundFundMe(address(fundMe));
        fundFundMe.fundFundMe{value: SEND_VALUE}();
        vm.stopPrank();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    function testUserCannotFundWithZeroValue() public {
        vm.startPrank(USER);
        FundFundMe fundFundMe = new FundFundMe(address(fundMe));
        vm.expectRevert();
        fundFundMe.fundFundMe{value: 0}();
        vm.stopPrank();
    }

    function testFundMeBalanceIncreases() public {
        vm.startPrank(USER);
        FundFundMe fundFundMe = new FundFundMe(address(fundMe));
        fundFundMe.fundFundMe{value: SEND_VALUE}();
        vm.stopPrank();

        uint256 balance = address(fundMe).balance;
        assertEq(balance, SEND_VALUE);
    }
}
