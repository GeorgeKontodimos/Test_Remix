// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract WelcomeToSolitity {
    constructor() {
    }
    function getResult() public pure returns (uint){
         uint  a = 1;
        uint b = 2;
        return (a + b)*5;
    }
}