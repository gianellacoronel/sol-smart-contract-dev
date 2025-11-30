//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//library is similar tu a contract
library PriceConverter {
    function getPrice() internal view returns(uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // () when function returns a lot of values
        //(uint80 roundId, int256 price, uint256 startedAt, uint256 timestamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        // Like we only need "price", we can delete the rest, keeping the commas
        (,int256 price,,,) = priceFeed.latestRoundData();

        //Price of ETH in terms of USD
        //Learning how to cast numbers
        return uint256(price * 1e10);
    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        //1 ETH?
        uint256 ethPrice = getPrice(); //2000_000000000000000000
        
        // Always you want to multiply before divide
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; //(2000_000000000000000000 * 1_0000000000000000000) / 1e18;
        
        return ethAmountInUsd; //$2000 = 1ETH
    }
}