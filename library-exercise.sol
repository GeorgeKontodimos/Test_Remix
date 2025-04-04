// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
library ArithmeticCalclations{
   
   function add(uint a, uint b) external view returns (uint,address){
        return (a + b,msg.sender);
    }
    function subtract(uint a , uint b ) external view returns (uint,address){
        return (a - b,msg.sender);
        
    }
    function multiply(uint a, uint b  ) external view returns (uint,address){
        return (a * b,msg.sender);
    }
    function divide(uint a , uint b) external view returns (uint,address){
        require(b>0, 'b cannot be zero');
        return (a / b,msg.sender);
    }
}
contract Test{
    address owner;
    constructor(){owner= msg.sender;}
    using ArithmeticCalclations for uint;
   function Addition(uint val1,uint val2 )public  view returns(uint) {
     (uint result,address sender)= val1.add(val2);
     require(sender == owner,'you are not the owner!');
    return result; 
   }
}