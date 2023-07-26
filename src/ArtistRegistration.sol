//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {ListDB} from "./Data.sol";

contract ArtistRegistration is ListDB {
    event artistRegistrated(address indexed _artist, uint256 _whenjoined);

    function register(string memory _name) external {
        isUser[msg.sender] = true;
        artistList.push(msg.sender);
       
        emit artistRegistrated(msg.sender, block.timestamp);

        artistInfo[msg.sender].name = _name;
    }
}

