// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Import from Github a NPM-Package
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// All library-functions have to be internal
library PriceConverter {
        function getPrice() internal view returns (uint) {
        // Interaction with outside contract -> ABI and address needed
        // Address from docs.chain.link, ABI (= functionnames) from import
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // The commas are necessary because 5 variables are returned
        (,int price,,,) = priceFeed.latestRoundData();
        // Price * 1e10 because price has 8 decimals and msg.value has 18
        // Typecasting to uint because msg.value is a uint
        return uint(price * 1e10);
    }
    function getConversionRate(uint ethAmount) internal view returns (uint) {
        uint ethPrice = getPrice();
        // In Solidity multiply and add first before dividing
        // Divided by 1e18 because (3*10**21)*(2*10**18) / (1*10**18) = (6*10**21)
        uint ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}