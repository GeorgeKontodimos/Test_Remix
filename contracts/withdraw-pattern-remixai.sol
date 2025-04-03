// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SecureBank {
        mapping(address => uint256) public balances;
         bool internal locked;
        modifier nonReentrant() {
            require(!locked);
            
            locked = true;
            
            _; // Code to be executed within this function
            
            locked = false;
        }
        
        constructor() payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public nonReentrant returns (bool){
        if(amount > 0 && balanceOf(msg.sender)>=amount)
            {
                require(balances[msg.sender]>=amount);
                uint newbalance =balances[msg.sender]-amount; 
                balances[msg.sender]=newbalance ;
                    return true;
            }
            else
            {  
                revert("Amount is too large or insufficient");
            }

        

    }

    function balanceOf(address _owner) public view returns (uint256){
    require(_owner != address(0));
    uint ownerBalance =balances[_owner];
        if(ownerBalance==0)
        {
            revert("Owner has no funds.");
            }
        
    return ownerBalance;
    }
}