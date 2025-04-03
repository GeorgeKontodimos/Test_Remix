// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// Let's build a contract with modified restricted access with the following common writeouts:
// onlyBy - only the mentioned caller can call this function.
// onlyAfter - called after certain time period.
// costs - call this function only if certain value is provided.

contract RestrictedAccess{
    address public owner= msg.sender;
    uint public creationTime = block.timestamp;

    modifier onlyBy(address _account){
        require(_account == msg.sender, "Sender not authorized!"); 
        _;  
    }
    
    modifier onlyAfter(uint _time){
        require(block.timestamp >= _time, "This function can be called after certain time"); // This condition will fail if current time is less than or equal to the specified time. 
        _;  
        
    }
    
    modifier costs(uint _amount){
       require(msg.value >= _amount, "Not enough Ether provided!");
       _;  
    }


    function changeOwnerAddress(address _newAddress)public onlyBy(owner){
        
        owner = _newAddress;
    }
    function disown()public onlyBy(owner) onlyAfter(creationTime + 3 weeks){
        delete owner;
    }
    function forceOwnerChange(address _newOwner)public payable costs(200 ether){
        owner = _newOwner;
    }
}