// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester{
    uint8 public bigNumber = 255; //unchecked     //In ^0.8.0, this is "checked", and when whe add 1, it gives us an error.

    function add() public {
        bigNumber = bigNumber + 1; //In ^0.6.0, 255 + 1 will return 0, because that number reset.

        // If we want to make it unchecked again, and make an overflow
        // unchecked {bigNumber = bigNumber + 1;}
    }
}
