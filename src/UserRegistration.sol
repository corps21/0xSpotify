//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {ListDB} from "./Data.sol";

contract UserRegistration {

    ListDB listDb;

    constructor(address _addOfList) {
        listDb = ListDB(_addOfList);
    }

    error alreadyRegistered();

    event userRegistered(address indexed _user, uint256 _whenjoined);

    function register(string calldata _name) external {
        if(listDb.getIsArtist[msg.sender] !== false) {
            revert alreadyRegistered();
        }
        listDb.setIsArtist(msg.sender,false);
        listDb.setArtistList(msg.sender);
        emit userRegistered(msg.sender, block.timestamp);
    }
}