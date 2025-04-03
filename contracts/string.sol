// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract learnStrings{
    string greetings = unicode'Hello Γιώργο!\nYou\'re hear now!';
    function sayHi() public view returns(string memory){
        return greetings ;
    }
    function changeGreeting(string memory _change) public {
        greetings=_change;
    }
       
    function getChar() public view returns (uint){
        return bytes(greetings).length;
    }
    function getCharAbi() public view returns (uint){
        bytes memory b = abi.encodePacked(greetings);
    return b.length;
    }

}