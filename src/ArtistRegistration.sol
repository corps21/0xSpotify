//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Data} from "./Data.sol";
contract ArtistRegistration {

    Data data;

    uint256 constant REGISTRATION_FEE = 1 * 1e18;

    error alreadyRegistered();
    error sendExactFee();

    constructor(address _addofList) {
        data = Data(_addofList);
    }

    event artistRegistrated(address indexed _artist, uint256 _whenjoined);

    function register(string calldata _name) external payable {
        if(data.getIsArtist(msg.sender) != false) {
            revert alreadyRegistered();
        }

        else if(msg.value != REGISTRATION_FEE) {
            revert sendExactFee();
        } 

        data.setIsArtist(msg.sender,false);
        data.setArtistList(msg.sender);
        data.setArtistInfoLogs(msg.sender,_name,bytes32(0),true);
        emit artistRegistrated(msg.sender,block.timestamp);
    }


}

