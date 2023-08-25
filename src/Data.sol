//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract ListDB {
    address[] userList;

    function getUserList() external view returns (address[] memory) {
        return userList;
    }

    function setUserList(address _user) external {
        userList.push(_user);
    }

    mapping(address => bool) isUser;

    function getIsUser(address _user) external view returns (bool) {
        return isUser[_user];
    }

    function setIsUser(address _user, bool _toDeactivate) external {
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

    address[] artistList;

    function getArtistList() external view returns (address[] memory) {
        return artistList;
    }

    function setArtistList(address _artist) external {
        artistList.push(_artist);
    }

    mapping(address => bool) isArtist;

    function getIsArtist(address _artist) external view returns(bool) {
        return isArtist[_artist];
    }

    function setIsArtist(address _artist ,bool toDeactivate) external {
        isArtist[_artist] = !toDeactivate;
    }


    mapping(address => ArtistInfo) artistInfoLogs;

    function getArtistInfoLogs(address _artist) external view returns (ArtistInfo memory) {
        return artistInfoLogs[_artist];
    }

    function setArtistInfoLogs(address _artist, string calldata _name, bytes32 codeToSong,bool duringRegistration) external{
        if(duringRegistration) {
            artistInfoLogs[_artist].name = _name;
        }

        else {
            artistInfoLogs[_artist].songCreated.push(codeToSong);
        }
    }

    struct ArtistInfo {
        string name;
        bytes32[] songCreated;
    }
}
