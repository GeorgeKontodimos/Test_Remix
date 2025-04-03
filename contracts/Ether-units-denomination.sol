// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// Ether Units
// Ethereum is the blockchain and Ether is the currency for Ethereum
contract learnEtherUnis{
    function test() public pure {
        //wei is the smallest denomination of ether
        assert(1000000000000000000 wei == 1 ether);
        assert(1 wei ==1);
        assert(1 ether == 1e18);
    }
}