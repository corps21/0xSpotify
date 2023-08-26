//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Data} from "../src/Data.sol";
import {ArtistRegistration} from "../src/ArtistRegistration.sol";
import {UserRegistration} from "../src/UserRegistration.sol";

contract DataDeploy is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Data data = new Data();
        ArtistRegistration artistRegistration = new ArtistRegistration(address(data));
        UserRegistration userRegistration = new UserRegistration(address(data));
        data.setAccess(address(artistRegistration));
        data.setAccess(address(userRegistration));
        vm.stopBroadcast();
    }
}
