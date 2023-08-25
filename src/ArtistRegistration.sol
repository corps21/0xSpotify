//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {ListDB} from "./Data.sol";
contract ArtistRegistration {

    ListDB listDb;

    uint256 constant REGISTRATION_FEE = 1 * 1e18;

    error alreadyRegistered();
    error sendExactFee();

    constructor(address _addofList) {
        listDb = ListDB(_addofList);
    }

    event artistRegistrated(address indexed _artist, uint256 _whenjoined);

    function register(string calldata _name) external {
        if(listDb.getIsArtist[msg.sender] !== false) {
            revert alreadyRegistered();
        }

        else if(msg.value !== REGISTRATION_FEE) {
            revert sendExactFee();
        } 

        listDb.setIsArtist(msg.sender,false);
        listDb.setArtistList(msg.sender);
        listDb.setArtistInfoLogs(msg.sender,_name,bytes32(0),true);
        emit artistRegistrated(_msg.sender,block.timestamp);
    }


}

