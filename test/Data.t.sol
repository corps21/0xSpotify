//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Data} from "../src/Data.sol";
import {AccessControl} from "../src/AccessControl.sol";

contract testData is Test {
    Data data;
    AccessControl accessControl;
    address addOfOwner = makeAddr("Owner");
    address addOfAttacker = makeAddr("Attack");
    address addOfTestContract = makeAddr("Test");
    address addOfUser = makeAddr("User");

    function setUp() public {
        vm.startPrank(addOfOwner);
        accessControl = new AccessControl();
        data = new Data();
        accessControl.setAccess(addOfTestContract);
        vm.stopPrank();
    }

    function test_setUserList() external {
        vm.startPrank(addOfTestContract);
        data.setUserList(addOfUser);
        vm.stopPrank();

        address[] memory result = data.getUserList();
        assertEq(result[0], addOfUser);
    }

}