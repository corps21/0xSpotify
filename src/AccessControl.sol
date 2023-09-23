//SPDX-License-Identifier:MIT
pragma solidity 0.8.19;

contract AccessControl {
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => bool) hasAccess;

    modifier onlyOwner() {
        require(msg.sender == owner, "Access Denied");
        _;
    }

    modifier onlyContracts() {
        require(hasAccess[msg.sender] == true);
        _;
    }

    function setAccess(address _addOfContract) external onlyOwner {
        hasAccess[_addOfContract] = true;
    }

    function getAccess(address _addOfContract) external view returns(bool) {
        return hasAccess[_addOfContract];
    }
}
