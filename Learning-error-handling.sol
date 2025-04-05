// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

/*
    Solidity has functions that help with error handling
    A way of tracking this is that when an error happens,
    the state reverts back to its original state.
    Important methods for error handling:
    require(condition) – Will halt execution if condition is false
        assert(bool condition) - In case condition is NOT met,
        this method call causes invalid optcode and any changes
        done to state got reverted. This method is to be used for internal errors.

        require (condition) – In case condition is NOT met,
        this method call reverts to original state. This method should be used
        for errors in inputs or external components.

        require (condition,string memory message) - In case condition is NOT met,
        this method call reverts to original state.This method should be used
        for errors in inputs or external components. It provides an option for a custom message.

        revert() –This method aborts the execution and revert any changes done to the state.

        revert(string memory reason) - This method aborts the execution and revert any changes done to the state.
        It provides an option for a custom message.
 */
contract LearnErrorHandling{
    bool public sunny =true;
    bool umbrella = false;
    uint finalCalc =0;
    // solar panel machine
    function solarCalc() public{
        require(sunny,'It is not suny today');
        finalCalc+=3;
        assert(finalCalc!=6);
    }
    
    //finaCalc can never equal 6
    function internalTestUnits()public view{
        assert(finalCalc!=6);
    }


    // machine that controls weather conditions
    function weatherChanger() public{
        sunny = !sunny;
    }
    // grab finalCalc
    function getCalc() public view returns (uint){
        return finalCalc;
    }

    function bringUmbrella() public {
        if(!sunny){
            umbrella = true;
        }
        else
        revert("No need to bring umbrellas without sun");
    }
}