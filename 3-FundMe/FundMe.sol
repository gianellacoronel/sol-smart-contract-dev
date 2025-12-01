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

    address public owner;

    constructor() { //It's a function that is inmediately called whenever you deploy your contract
        owner = msg.sender;
    }
    
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
    
    function withdraw() public onlyOwner{
        // for loop
        // [1, 2, 3, 4] elements
        //  0, 1, 2, 3  indexes
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; // We want to reset the array, because we are doing a withdraw   
        }

        // reset the array
        funders = new address[](0); //Start with a length of 0
        // actually withdraw the funds
        //there are three different ways
        // // 1. Transfer
        //     // msg.sender = address
        //     // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);    //"this" refers to the whole contract
        // //If it fails, the process revert
        
        // // 2. Send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // //If it fails, the value will be false, because the return is a boolean
        // require(sendSuccess, "Send failed"); // With this, if it's false, it would revert the transaction
        
        // 3. Call
        // With can call a function inside call()
        // (bool callSuccess, bytes memory dataReturned)
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    //modifiers: something that we can put in a function, to add additional functionality
    modifier onlyOwner() {
        require(msg.sender == owner, "Sender is not owner!");
        _; //this represents the rest of the code
    }
}