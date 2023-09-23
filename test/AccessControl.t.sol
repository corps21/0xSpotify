//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {AccessControl} from "../src/AccessControl.sol";

contract TestAccess is Test {
    address addOfOwner = makeAddr("Owner");
    address addOfAttacker = makeAddr("Attack");
    address addToBeSet = makeAddr("Contract");
    
    AccessControl accessControl;

    function setUp() public {
        vm.startPrank(addOfOwner);
        accessControl = new AccessControl();
        vm.stopPrank();
    }

    function test_setAccess() external {
        vm.startPrank(addOfOwner);
        accessControl.setAccess(addToBeSet);
        vm.stopPrank();

        assertEq(accessControl.getAccess(addToBeSet),true);
    }

    function test_failsetAccess() external {
        vm.startPrank(addOfAttacker);
        vm.expectRevert();
        accessControl.setAccess(addToBeSet);
        vm.stopPrank();
    }
}