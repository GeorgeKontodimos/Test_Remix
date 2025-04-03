// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
// Eg.
// msg.sender: Sender of the message (current call). msg.value (uint): Number of wei sent with the message.,
// block,timestamp: Current block timestamp at seconds since unix epoch, block.number (uint): current block number.

contract LedgerBalance{ //καθολική ισορροπία
// create a map of wallets with ammounts
// set up a function that can update the amount of the person call the contract - current address - msg.Sender

mapping (address=>uint256   ) public balances;
// this was autocreated
function deposit() external payable{ //deposit function 
        require(msg.value>0, "insufficient funds");//ensures the amount is more than 0 - if it is not then stop

        balances[msg.sender]+= msg.value;    }
// this is the instructur example
function updatesBalance(uint newBalance) public{
    balances[msg.sender] = newBalance;
    }

}
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//0x22a39bfc
contract Updated{
    function updatesBalance() public {
        LedgerBalance ledgerBalance = new LedgerBalance();
        ledgerBalance.updatesBalance(30);
    }
}
//other Global Variables Examples

contract SimpleStorage{
    uint storedData;
    function set(uint x) public{
        storedData = x;
        storedData = block.difficulty;
        storedData = block.timestamp;
        storedData = block.number;
    }
    
    function get()public view returns (uint){ 
        // view,pure, returns and pure are similar to a normal functions - they do not modify the data in storage so it is immutable. 
        return storedData;  
    }
}

