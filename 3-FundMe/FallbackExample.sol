// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // receive is a special keyword in Solidity
    // If someona sends ETH to the contract address, receive() will be trigger
    // This is triggered if CALLDATA input in Remix is blank
    receive() external payable {
        result = 1;
    }
    
    // I understand for CALLDATA input, a place to write the name of a function to make a transaction
    // Whenever data is send in the CALLDATA input, and not exist in the list of functions, it will search for "fallback" function
    fallback() external payable { 
        result = 2;
    }

    //Both of these functions doesn't need the "function" keyword
}