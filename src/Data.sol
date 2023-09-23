//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {AccessControl} from "./AccessControl.sol";

contract Data is AccessControl {
    address[] private s_userList;

    mapping(address => bool) private s_isUser;

    mapping(address => UserInfo) private s_userInfoLogs;

    struct UserInfo {
        string name;
        address[] artistFollowed;
        bytes32[] likedSongs;
    }

    struct Song {
        string name;
        Genre genreOfSong;
    }

    enum Genre {
        ROCK,
        BLUES,
        HIPHOP,
        JAZZ,
        RNB,
        INDIE,
        POP
    }

    mapping(bytes32 => Song) private s_idToSong;

    mapping(bytes32 => address) private s_fromIdToArtist;

    address[] private s_artistList;

    struct ArtistInfo {
        string name;
        bytes32[] songCreated;
    }

    mapping(address => ArtistInfo) private s_artistInfoLogs;

    mapping(address => bool) private s_isArtist;

    /**
     * Setter Functions
     */

    function setUserList(address _user) external onlyContracts {
        s_userList.push(_user);
    }

    function setIsUser(address _user, bool _toDeactivate) external onlyContracts {
        s_isUser[_user] = !_toDeactivate;
    }

    function setUserInfo(
        string calldata _name,
        address _artistFollowed,
        bytes32 idOfSong,
        bool duringRegistration,
        address _user,
        bool isLiked
    ) external {
        if (duringRegistration) {
            s_userInfoLogs[_user].name = _name;
        } else if (_artistFollowed != address(0)) {
            s_userInfoLogs[_user].artistFollowed.push(_artistFollowed);
        } else if (isLiked) {
            s_userInfoLogs[_user].likedSongs.push(idOfSong);
        }
    }

    function setIsArtist(address _artist, bool toDeactivate) external onlyContracts {
        s_isArtist[_artist] = !toDeactivate;
    }

    function setArtistList(address _artist) external onlyContracts {
        s_artistList.push(_artist);
    }

    function setArtistInfoLogs(address _artist, string calldata _name, bytes32 codeToSong, bool duringRegistration)
        external
        onlyContracts
    {
        if (duringRegistration) {
            s_artistInfoLogs[_artist].name = _name;
        } else if (codeToSong != bytes32(0)) {
            s_artistInfoLogs[_artist].songCreated.push(codeToSong);
        }
    }

    /*
        *Getter Functions
    */

    function getUserList() external view returns (address[] memory) {
        return s_userList;
    }

    function getIsUser(address _user) external view returns (bool) {
        return s_isUser[_user];
    }

    function getArtistList() external view returns (address[] memory) {
        return s_artistList;
    }

    function getIsArtist(address _artist) external view returns (bool) {
        return s_isArtist[_artist];
    }

    function getArtistInfoLogs(address _artist) external view returns (ArtistInfo memory) {
        return s_artistInfoLogs[_artist];
    }
}
