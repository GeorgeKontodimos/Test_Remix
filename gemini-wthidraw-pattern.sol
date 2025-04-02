/*
You bet! Let's dive into the "Checks-Effects-Interactions" pattern, 
which is a super important way to structure your Solidity functions, 
especially when dealing with things like withdrawing funds. 
It helps prevent reentrancy attacks, which can be nasty!
Think of it like this: you want to make sure everything 
is in order before you actually make any changes or talk to other contracts.

Here's how it looks in the context of a withdrawal:
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureBank {
    mapping(address => uint256) public balances;
    bool internal locked;

    modifier nonReentrant() {
        require(!locked, "Reentrant call.");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public nonReentrant {
        // 1. Checks: Make sure everything is good to go!
        require(balances[msg.sender] >= amount, "Insufficient balance.");

        // 2. Effects: Update the state of *this* contract.
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount); // It's good practice to emit events

        // 3. Interactions: Only now do we interact with external things (like sending Ether).
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    event Withdrawal(address indexed account, uint256 amount);
}

/*
Let's break down why this pattern is so cool:
Checks First: We start by checking if the user has enough money 
(require(balances[msg.sender] >= amount, "Insufficient balance.");). 
If not, the function stops right there, and no changes are made.
Effects Next: Once we know the withdrawal is valid, we immediately 
update the balances mapping within our 
SecureBank contract (balances[msg.sender] -= amount;). 
We also emit an event, which is a great way to log what happened 
on the blockchain. The key here is that we've recorded the change 
in our contract's state before sending any Ether.
Interactions Last: Finally, and only after our internal state 
is updated, do we actually send the Ether to the user 
(msg.sender.call{value: amount}("");). 
If this external transfer fails for some reason, our contract's balance 
has already been correctly updated, preventing potential inconsistencies.
Why is this important for security (like preventing reentrancy)?
Imagine a malicious contract that receives Ether from the withdraw function.
 Within its fallback function (a special function that gets called when 
 it receives Ether), it could try to call the withdraw function of the 
 SecureBank again before the original withdrawal transaction is fully completed.
Without the Checks-Effects-Interactions pattern (and especially 
without something like the nonReentrant modifier I've added as an extra
 layer of protection), the malicious contract could potentially withdraw 
 more Ether than it should be allowed to.
By updating the balance before the transfer, even if the malicious 
contract tries to call withdraw again in the middle of the first withdrawal,
 the check require(balances[msg.sender] >= amount, "Insufficient balance.");
  will likely fail because the balance has already been reduced.
The nonReentrant modifier adds an extra layer of defense by using 
a state variable (locked) to prevent the function from being called 
again before it has finished executing. This is a common and highly
 recommended practice for functions that interact with external contracts
  or handle sensitive state changes.
So, the Checks-Effects-Interactions pattern isn't just about being organized; 
it's a fundamental security principle in Solidity development!
 It helps you build more robust and safer smart contracts.
*/