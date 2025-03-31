// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract enumsLearn{
    enum frenchFriesSize {SMALL, MEDIUM, LARGE}
    frenchFriesSize choice;
    frenchFriesSize constant defaultChoice = frenchFriesSize.MEDIUM;
    function setSmall() public{
        choice = frenchFriesSize.SMALL;
    }
    function setMedium() public{
        choice = frenchFriesSize.MEDIUM;
    }
    function setLarge() public{
        choice = frenchFriesSize.LARGE;
    }
    function getChoice() public view returns(frenchFriesSize){
        return frenchFriesSize(choice);
    }

}