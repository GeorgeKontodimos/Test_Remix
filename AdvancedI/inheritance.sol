// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;




contract A {
    uint innerVal = 100;
    function innerAddTen(uint _any)public pure returns (uint) {
       return _any + 10;
    }
}

contract B is A{
     function outerAddTen(uint _any) public pure returns (uint){
        return innerAddTen(_any);
     }
     function getInnerVal() public view returns (uint val) {
        return innerVal;
     }
}