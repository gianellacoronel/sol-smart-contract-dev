// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//importing interface from Chainlink documentation
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 5;
    
    function fund() public payable {
        
        //Allow users to $ sent
        // Have a minimum $ sent 
        // 1. How do we send ETH to this contract?

        // msg.value is the amount you put on Deploy & run transactions tab
        require(msg.value > minimumUsd, "didn't send enough ETH");

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // If a code line is rejected, that reverts the previous operations, and spend gas.
    }
    
    function withdraw() public {}

    function getPrice() public {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
    }
    function getConversionRate() public {}

}