// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

/* 
Define Fallback Functions
1. Cannot have a name (anonymous)
2. Does not take any inputs
3. Does not return any outputs
4. Must be declared as 'external' 
Why use it? When you call a function that does not exist , 
or send to a contract by send, transfer or call statement:
send and transfer methods recieves 2300 gas but call method receives more (all of the gas)

*/

contract Fallback{
    event Log(uint gas);
    fallback() external payable { 
        // Calling a method that does not exist will lead to the execution of this fallback function
        // not recommended to write too much code in here 
        // because is gonna fail if it uses too much gas
        // ===============================================
        // invoke send and transfer methods : we get 2300 gas which is enough to emit a log
        // invoke the call method : we get all the gas
        // special solidity function gasleft -> returns how much gas is left
       emit Log(gasleft());
    } 
    function getBalance() public view returns (uint) { 
        // return the stored balance of the contract
        return  address(this).balance;
    }
}
// new contract will send ether to Fallback contract which will trgger fallback functions
contract SendToFallBack{
    function transferToFallBack(address payable _to )public payable {
        // send ether with the transfer method
        // automatically also transfer 2300 gas amount
        _to.transfer(msg.value);
    }
    function callFallBack(address payable _to )public payable{
        (bool sent,)=_to.call{value: msg.value}(''); 
        require(sent,'Failed to send ether');
    }
}
