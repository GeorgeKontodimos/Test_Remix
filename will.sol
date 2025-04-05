// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 < 0.9.0;

contract will{
    address owner;
    uint fortune;
    bool deceased;
    constructor () payable{
        owner=msg.sender;
            fortune=msg.value;
        deceased =false;
    }
    modifier onlyOwner{
        require (owner==msg.sender);
        _; // continue with the function
    }
    modifier mustBeDeceased{
       require (deceased==true);
       _;
    }
    // list of family wallets;
    address payable [] familyWallets;
    // map through inharitance
    mapping(address=>uint) inheritance;
    // set Inheritance for each address;
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet]=amount;
    }

    function payout() mustBeDeceased private {
        for (uint i=0; i<familyWallets.length; i++) 
        {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            // transfering from contract address to receiver address
        }
    }

}