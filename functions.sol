// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract learnFunctions {
    // function-name(parameter-list) scope return() {
        // statement
    // } 
     // uint256 public num = 17;
   /* int x, y ; */
       /** @dev This is a private function. It is not accessible to other contracts or functions within the same contract. The keyword "private" makes it so that it can only be used by the contract itself.  */
      function _add() public pure returns(uint){ //this fucntion is a private function
        uint x =5;
        uint y =6;
        uint z = x + y;
        return z;
       }
        function _multi(uint x,uint y) public pure returns(uint){ //this fucntion is a private function
            uint result = x * y;
        return result;
     }
}
