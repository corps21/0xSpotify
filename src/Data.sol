//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {AccessControl} from "./AccessControl.sol";

contract Data is AccessControl{

    //User Section

    address[] userList;

    function getUserList() external view returns (address[] memory) {
        return userList;
    }

    function setUserList(address _user) external onlyContracts {
        userList.push(_user);
    }

    mapping(address => bool) isUser;

    function getIsUser(address _user) external view returns (bool) {
        return isUser[_user];
    }

    function setIsUser(address _user, bool _toDeactivate) external onlyContracts {
        isUser[_user] = !_toDeactivate;
    }

    mapping(address => UserInfo) userInfoLogs;

    struct UserInfo {
        string name;
        address[] artistFollowed;
        bytes32[] likedSongs;
    }

    //test for gas for other approaches
    function setUserInfo(
        string calldata _name,
        address _artistFollowed,
        bytes32 idOfSong,
        bool duringRegistration,
        address _user,
        bool isLiked
    ) external {
        if (duringRegistration) {
            userInfoLogs[_user].name = _name;
        } else if (_artistFollowed != address(0)) {
            userInfoLogs[_user].artistFollowed.push(_artistFollowed);
        } else if (isLiked) {
            userInfoLogs[_user].likedSongs.push(idOfSong);
        }
    }

    //Song Section

    struct Song {
        string name;
        Genre genreOfSong;
    }

    mapping(bytes32 => Song) idToSong;
    mapping(bytes32 => address) fromIdToArtist;

    enum Genre {
        ROCK,
        BLUES,
        HIPHOP,
        JAZZ,
        RNB,
        INDIE,
        POP
    }

    //Artist Section 

    address[] artistList;

    function getArtistList() external view returns (address[] memory) {
        return artistList;
    }

    function setArtistList(address _artist) external onlyContracts {
        artistList.push(_artist);
    }

    mapping(address => bool) isArtist;

    function getIsArtist(address _artist) external view returns(bool) {
        return isArtist[_artist];
    }

    function setIsArtist(address _artist ,bool toDeactivate) external onlyContracts {
        isArtist[_artist] = !toDeactivate;
    }


    mapping(address => ArtistInfo) artistInfoLogs;

    function getArtistInfoLogs(address _artist) external view returns (ArtistInfo memory) {
        return artistInfoLogs[_artist];
    }

    function setArtistInfoLogs(address _artist, string calldata _name, bytes32 codeToSong,bool duringRegistration) external onlyContracts{
        if(duringRegistration) {
            artistInfoLogs[_artist].name = _name;
        }

        else if(codeToSong != bytes32(0)){
            artistInfoLogs[_artist].songCreated.push(codeToSong);
        }
    }

    struct ArtistInfo {
        string name;
        bytes32[] songCreated;
    }
}
