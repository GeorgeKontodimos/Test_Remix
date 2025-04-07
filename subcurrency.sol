// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;


// The contract allows only its creator to create new coins (different issuance schemes are possible).
// Anyone can send to each other without a need for registaring with username and password,
// all you need is an Ethereum keypair.
contract Coin {
    address public minter;
    mapping (address=>uint)  public  balances;
      // Events allow clients to react to specific 

    event Sent(address from, address to,uint amount);

    constructor(){ minter=msg.sender;}

    function mint(address receiver, uint amount)payable public {
         require(msg.sender==minter);
         balances[receiver]+=amount; 
         emit Sent(msg.sender,receiver,amount);
    }
     function send(address receiver,uint amount)payable public{ 
        require(balances[msg.sender]>=amount,
        "insufficient balance ${(msg.sender)}");
        require(balances[receiver]!=0,"address not found"); //exists
         balances[msg.sender]-=amount;
         balances[receiver]+=amount;
         emit Sent(msg.sender,receiver,amount);
         }
}