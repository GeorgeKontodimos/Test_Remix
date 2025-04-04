// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// Libraries are similar to Contracts bat are mainly intended for reuse.
// A library contains functions which other contracts can call.
// Solidity have certain restrictions on use of a Library.
// Library functions can be called directly if they do not modify the state.
// That means pure or view functions only can be called from outside the library.
// Library can not be destroyed as it is assumed to be stateless.
// A library cannot have state variables.
// A library cannot inherit any element.
// A library cannot be iherited.


library Search{
    function indexOf(uint[] storage self, uint value) public view returns (uint256) {
        for(uint i = 0;i < self.length;++i ) if(self[i] == value) return i;
        // Add this line to handle the case where no match is found
        return self.length;
    }
}

contract Test{
    uint[] data;
    constructor() {for (uint i = 0;i < 5; i++) data.push(i);}
    
     function testFunction(uint val) public view returns(uint256){
        return Search.indexOf(data,val);
        // You can use the indexOf method as shown above
    }
}
// =================  using  library pattern "using A for B" ===============
library Search2{
    function indexOf(uint[] storage self, uint value) public view returns (uint256) {
        for(uint i = 0;i < self.length;++i ) if(self[i] == value) return i;
        // Add this line to handle the case where no match is found
        return self.length;
    }
}

contract Test2{
    using Search2 for uint[];
    uint[] data;
    constructor() {for (uint i = 0;i < 5; i++) data.push(i);}
    
     function testFunction(uint val) public view returns(uint256){
        return data.indexOf(val);
        // You can use the indexOf method as shown above
        
    }
}