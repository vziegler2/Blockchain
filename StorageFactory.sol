// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//includes the path, package or github of another file
import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public {
        simpleStorageArray.push(new SimpleStorage());
    }
    function sfStore(uint _simpleStorageIndex, uint _simpleStorageNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    function sfGet(uint _simpleStorageIndex) public view returns(uint){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}