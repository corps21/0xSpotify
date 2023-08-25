//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Data} from "./Data.sol";

contract UserRegistration {

    Data data;

    constructor(address _addOfList) {
        data = Data(_addOfList);
    }

    error alreadyRegistered();

    event userRegistered(address indexed _user, uint256 _whenjoined);

    function register(string calldata _name) external {
        if(data.getIsUser(msg.sender) == true) {
            revert alreadyRegistered();
        }
        data.setUserList(msg.sender);
        data.setUserInfo(_name, address(0), bytes32(0), true, msg.sender, false);
        emit userRegistered(msg.sender, block.timestamp);
    }
}