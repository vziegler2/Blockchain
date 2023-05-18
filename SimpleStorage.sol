// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // bool, uint(8-256), int(8-256), string, address, bytes(1-32) are automatically initialized with 0
    // public (like view function), private, external, internal (standard)
    uint256 public favoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    // view doesn't change the blockchain -> no gas spend, unless called by a contract
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    // pure doesn't change or read from the blockchain -> no gas spend, unless called by a contract
    function add() public pure returns(uint256) {
        return(1 + 1);
    }
}