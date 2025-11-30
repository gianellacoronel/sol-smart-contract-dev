// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Importing my own library
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18; // We change it because we are using getConversionRate in fund function.
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    function fund() public payable {
        
        //Allow users to $ sent
        // Have a minimum $ sent 
        // 1. How do we send ETH to this contract?

        // msg.value is the amount you put on Deploy & run transactions tab
        //require(getConversionRate(msg.value) > minimumUsd, "didn't send enough ETH");
        
        msg.value.getConversionRate(); //"msg.value is like the parameter for getConversionRate"
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enought ETH");
        funders.push(msg.sender); //It's the account that do the transaction
        addressToAmountFunded[msg.sender] += msg.value;

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // If a code line is rejected, that reverts the previous operations, and spend gas.
    }
    
    function withdraw() public {
        // for loop
        // [1, 2, 3, 4] elements
        //  0, 1, 2, 3  indexes
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; // We want to reset the array, because we are doing a withdraw   
        }
    }
}