// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Member {
    string name;
    uint age;

    // initialize name and age upon deployment
    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }
}


// is an option to call the constructor
contract Teacher is Member //('George',60) 
{
    constructor(string memory _name, uint _age) Member(_name, _age){}
    function getName() public view returns (string memory) {
        return name;
    }
}

contract Base{
     uint data ;
     constructor(uint _data ){
        data = _data;
     }
     function getData()public view returns (uint)  {
            return data;
    }
}

contract Derived is Base (5) {
    function getBaseData()public view returns (uint)  {
            return data;
    }
}
contract Derived2 is Base  {
    constructor(uint _d ) Base(_d){}
    function getBaseData()public view returns (uint)  {
            return data;
    }
}

