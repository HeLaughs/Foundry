// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract TestFundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserAddress() public {
        assertEq(USER, makeAddr("user"));
    }

    function testSendValue() public {
        assertEq(SEND_VALUE, 0.1 ether);
    }

    function testStartingBalance() public {
        assertEq(STARTING_BALANCE, 10 ether);
    }

    function testGasPrice() public {
        assertEq(GAS_PRICE, 1);
    }
}