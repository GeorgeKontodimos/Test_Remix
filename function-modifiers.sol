// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
// Functionmodifiers are used to modify the behaviour of a function.
// eg. to add a prerequisite (προαπαιτούμενο) to a function

contract Owner{
    // function modifiers
    address owner;
    // when we deploy this contract we want to set the address to the owner (msg.sender)
    constructor() {owner=msg.sender;}

    modifier onlyOwner(){
        // so we add a prerequisite — if the sender is not the owner we throw an error. This has the effect of preventing anyone else
        require(msg.sender==owner);
        _; // continue with the function
        }
    modifier costs(uint cost){
        // what is msg.value:  is the amount being sent with a message to a contract
        require(msg.value>=cost);
        _;
    }
}

contract Register is Owner {
    mapping (address=>bool) registeredAddress;
    uint price;

    constructor(uint _initialPrice) {price = _initialPrice;}

    function register() public payable costs(price){
        registeredAddress[msg.sender]=true;
    }
    // onlyOwner is our function modifier that reqires
    // only the owner to be able to change the price
    function changePrice(uint _price) public onlyOwner{
        price = _price;
    }
}