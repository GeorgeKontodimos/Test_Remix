// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Abstract  contract is one which contains at least one function without impementation.
// Such a contract is used as a base contract.
// Generally an abstract contract contains both implemented as well as abstarct functions.
// Derived contract will implement the abstract functions and use the existing functions
// as and when required.


// base
abstract contract X{
    // since the function han no implementation we should mark it as virtual.
    function y() public pure virtual returns (string memory);
}

// derived
contract Z is X{
     function y() override public pure virtual returns(string memory){
        return "hello";
    }
}   
// technically contract is abstract since it has at least one function without body
// base
contract Member{
    string name;
    uint age =38;
    //because function setName has no body the contract is abstract
    function setName(string memory _name) public  virtual {}
    function returnAge ()public view virtual returns(uint) {
        return age;
    }
}

// derived
contract Teacher  is Member{
    function setName(string memory _name) override public  virtual {
        name = _name;
    }
    function getName () public view returns (string memory ){
         return name;
    }
}

// Exercise
// base 
abstract contract Calculator{
    function sum(uint _a , uint _b) public  virtual returns (uint);
}
// derived 
contract Addition is Calculator {
    function sum(uint _a, uint _b ) override public view virtual returns (uint){
        return _a + _b;  
    }
}
// derived test
contract customAddition is Addition{
    function sum(uint  _x ,  uint  _y)public override view virtual  returns (uint){
        return (_x +_y +10);
    }
}