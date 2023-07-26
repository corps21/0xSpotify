//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {ListDB} from "./Data.sol";

contract UserRegistration is ListDB {
    event userRegistered(address indexed _user, uint256 _whenjoined);

    function register(string memory _name) external {
        isUser[msg.sender] = true;
        userList.push(msg.sender);

        emit userRegistered(msg.sender, block.timestamp);

        userInfo[msg.sender].name = _name;
    }
}