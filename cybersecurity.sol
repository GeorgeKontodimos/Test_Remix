// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

/*
Cybersecurity In Solidity - against bad actors, accidental occurances

Withdrawal pattern ensures that direct calls is not made which poses a security threat.
Transfers are atomic (meaning all or nothing!)

Write an iterating function called returnFunds that will refund through the transfer method investors to a var called
funders back to their wallets called cntributeAmount. Add a modifier to the signature that only
the owner can execute this function. The function should return a bool success.

*/
contract test{
    modifier onlyOwner{
        require(true);
        _;
    }
    function returnFunds() public onlyOwner returns  (bool success){
        for(uint i =0;funders.length;i++){
            funders[i].transfer(cntributeAmount);
        }
        return true;
    }


}

