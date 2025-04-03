// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;


// Event Example:
// Abstraction - Decentralized Excange: On a smart contract traders can trade tokens - 
// from the smart contract emit an event so they can get the data (web front mobile)

// After emitting events you can't read them in the past only for entities outside the of the blockchain -
// not stored as memory events have lower gas cost than storage
contract LearnEvents{
    // 1. declare the event 
    // only use 3 indexed per event
    event NewTade (uint indexed date, address from,
    address indexed to, uint indexed amount);
    // 2. emit the event
    function trade(address to, uint amount) external  {
        // .. do the trade then emit
        // outside consumer can see the event through web3js
        emit NewTade(block.timestamp,msg.sender,to,amount);
        }

}


// ai example


contract TradeManager {
    // 1. declare the event 
    event NewTrade(uint date, address from,address to, uint amount);
    // ...

    function makeTransaction(address _from, address _to, uint _amount) public {
        emit NewTrade(block.timestamp,_from,_to,_amount);
        
        // logic for transaction...
    }
}

// Using Web3.js library to interact with our contract...

// const myContract = new web3.eth.Contract(myAbi);

// myContract.methods.makeTransaction(fromAddress,toAddress,amount).send({
//     from: yourWallet,
// }).on('confirmation', confirmationNumber => {
//     console.log(`New trade event emitted!`);
// });