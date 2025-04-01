// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;


/*
public - all can access

external - Cannot be accessed internally, only externally

internal - only this contract and contracts deriving from it can access

private - can be accessed only from this contract*/

// View functions ensure that they will not modify the state (return values).
// Pure fumctions ensure that they not read or modify the state (return calculations).
contract viewOnlyFunction {
    uint public number = 5; // We can use this function as it is. 
    
    function getNumber() public view returns (uint) { // This will return a value of 5.
        return number;
    }
}
contract MyContarct{
    uint value;
    function setValue(uint _value) external {
        // eth send transaction
        value = _value; // This will update the state of the contract. 
        
    }
    function getValue() external view returns (uint) {// We are not changing the state, we are only returning a value.
        // eth call
        return value;  
    }
    function getPow2Of3() external pure returns (uint) {// We are not changing the state, we are only returning a value.
        // eth call
        return 3*3;  
    }
}
