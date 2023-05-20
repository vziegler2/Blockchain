// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    // PriceConverter-Functions can be applied directly to uint-values
    using PriceConverter for uint;
    uint public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint) public addressToAmountFunded;
    function fund() public payable {
        // If the fund amount is too small, everything before inside the function is reverted
        // msg.value has 18 decimals because the currency is Wei not ETH
        // msg.value.getConversionRate() instead of PriceConverter.getConversionRate(msg.value) because of using in line 8
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
}