//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Script} from '../lib/forge-std/src/Script.sol';
import {Data} from "../src/Data.sol";

contract DataDeploy is Script {
    function run() public {
        vm.startBroadcast();
        vm.stopBroadcast();

    }
}