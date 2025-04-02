// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

/*
It is not safe to interact with more than one customer 
at atime so write a function to return funds 
using withdrawl pattern.

1.Write a function called withdrawFunds that takes an amount and returns bool successin the signature.
2.Require that the balance of the caurrent caller is greater than or equal to the amount.
3.Substract the amount from the balance of the current sender.balance.
4.Transfer the amount over and return the trueness of the function.

*/
 contract Bank {
    mapping(address => uint256) public balance;

    function depositFunds() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawFunds(uint256 amount) public returns (bool success) {
        if (balance[msg.sender] >= amount) {
            balance[msg.sender] -= amount;
            payable(msg.sender).transfer(amount);
            return true;
        } else {
            return false;
        }
    }
}



contract WithdrawalContract {
    mapping(address => uint) public balance;

    function withdrawFunds(uint _amount) public returns (bool success){
        require(balance[msg.sender]>=_amount); // guards upfront
        balance[msg.sender] -= _amount;  // optimistic accounting
        payable (msg.sender).transfer(_amount); // transfer
        return true;
    }

}

