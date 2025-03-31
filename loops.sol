// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract loopContract{
    uint [] private  _list = [1,2,3,4,5,6,7,8,9,10] ;
    function checkMultipes(uint _number)public view  returns (uint){
        uint result = 0;
            for (uint i=0;i<_list.length;i++) {
                if(checkMultipes(_list[i] ,_number)){
                    result++ ;
                }
            }
            return result;
    }
    function checkMultipes(uint _num,uint _nums)private pure  returns (bool) {
return _num%_nums==0;
    }
}