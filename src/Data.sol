//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract ListDB {
    address[] userList;

    mapping(address => bool) isUser;

    mapping(address => UserInfo) userInfo;

    enum Genre {
        ROCK,
        BLUES,
        HIPHOP,
        JAZZ,
        RNB,
        INDIE,
        POP
    }

    struct UserInfo {
        string name;
        address[] artistFollowed;
        Song[] likedSong;
    }

    struct Song {
        string name;
        string artist;
        Genre genreOfSong;
        bytes32 idOfSong;
    }

    mapping(bytes32 => Song) idToSong;

    address[] artistList;

    mapping(address => bool) isArtist;

    mapping(address => ArtistInfo) artistInfo;

    struct ArtistInfo {
        string name;
        Song[] songCreated;
    }


}
