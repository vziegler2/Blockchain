// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    // PriceConverter-Functions can be applied directly to uint-values
    using PriceConverter for uint;
    // constant variables are more gas efficient
    uint public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint) public addressToAmountFunded;
    // immutable is like constant but declaration and definition separated
    // both are stored in the bytecode of the contract instead of a storage slot
    address public immutable i_owner;
    // owner = whoever deploys the contract
    constructor(){
        i_owner = msg.sender;
    }
    function fund() public payable {
        // If the fund amount is too small, everything before inside the function is reverted
        // msg.value has 18 decimals because the currency is Wei not ETH
        // msg.value.getConversionRate() instead of PriceConverter.getConversionRate(msg.value) because of using in line 8
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    function withdraw() public onlyOwner {
        for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
            // resets the array to a new address array with zero objects in it
            funders = new address[](0);
            // transfer (error and revert if gas > 2300), send (returns boolean if gas > 2300), call
            // sets msg.sender to type payable address instead of address
            // this refers to the whole contract
            // call allows to call different functions, eventual returns can be saved in a bytes variable (array)
            // call is used like a transaction with i.e. a value
            (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
            require(callSuccess, "Call failed");
        }
    }
    // Can be applied directly in function declarations
    // The underscore represents the place of the rest of the code of the modified function
    modifier onlyOwner {
        // more gas efficient than require with string-array
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }
    // receive and fallback execute fund if a transaction is received without the fund-function
    // constructor, receive and fallback are special functions that don't need the function keyword
    // receive is executed everytime a transaction without data is received
    receive() external payable {
        fund();
    }
    // fallback is executed if a transaction with data is received or there is no receive-function
    fallback() external payable {
        fund();
    }
}