// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// The contract allows only its creator to create new coins (different issuance schemes are possible).
// Anyone can send to each other without a need for registaring with username and password,
// all you need is an Ethereum keypair.

contract Coin{
    // keyword public accessible from other contracts
    address public minter;
    mapping (address=>uint) public balances;

    // Events allow clients to react to specific
    // contract changes you declare
    event Sent(address from, address to,uint amount);

    // constructor only runs when we deploy contract
    constructor(){
        minter=msg.sender;
    }

    // make new coins and send them to an address
    // only the owner can send these coins
    function mint(address receiver,uint amount) public {
        require(msg.sender==minter);
        balances[receiver]+=amount;
    }

    // send any amount of coins 
    // to an existing address

    error insufficientBalance(uint recuested,uint available);

    function send(address receiver,uint amount) public{
        //require(balances[msg.sender]>=amount); // require that the address has enough coins
        if(amount>balances[msg.sender])
        revert insufficientBalance({ recuested:amount, available:balances[msg.sender]});
        balances[msg.sender]-=amount;
        balances[receiver]+=amount;
        emit Sent(msg.sender,receiver,amount);
    }

}