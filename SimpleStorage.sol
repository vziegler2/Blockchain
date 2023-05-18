// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// EVM, Ethereum Virtual Machine
// Solidity-Code can be deployed to all EVM-compatible chains
// contracts are like classes
contract SimpleStorage {
    // bool, uint(8-256), int(8-256), string, address, bytes(1-32) are automatically initialized with 0
    uint favoriteNumber;    
    // key-value-dictionaries
    mapping(string => uint) public nameToFavoriteNumber;

    struct People {
        uint favoriteNumber;
        string name;
    }
    // public (like view function), private, external, internal (standard)
    People[] public people;
    // virtual makes the function in inherited contracts overridable
    function store(uint _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }
    // view doesn't change the blockchain -> no gas spend, unless called by a contract
    // pure doesn't change or read from the blockchain -> no gas spend, unless called by a contract
    function retrieve() public view returns(uint){
        return favoriteNumber;
    }
    //.push adds a new entry to the array people
    // For arrays, structs and mapping types:
    // calldata (temporarily and can't be modified), memory (temporarily), storage
    function addPerson(string memory _name, uint _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        //number at key _name is set to _favoriteNumber
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}