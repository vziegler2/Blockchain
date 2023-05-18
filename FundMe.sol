// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    uint public minimumUsd = 50;
    function fund() public payable{
        // If the fund amount is too small, everything before inside the function is reverted
        require(msg.value >= minimumUsd, "Didn't send enough");
    }
    //function withdraw(){
//
    //}
}