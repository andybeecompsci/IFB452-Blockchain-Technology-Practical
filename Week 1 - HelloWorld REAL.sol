// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.3 and less than 0.9.0
pragma solidity ^0.8.3;

contract HelloWorld {
    function sayHelloWorld() public pure returns (string memory) {
        return "Hello World";
    }
}

// public = anyone can call it 
// pure = doesnt read or modify any stat variables

// using pure bc doesnt need to interact w blockhain state (r/w), uses less gas