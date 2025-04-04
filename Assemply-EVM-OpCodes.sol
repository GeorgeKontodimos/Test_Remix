// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// Solidity provides an option to use assembly language 
// to write inline assembly within solidity source code.
// Assembly is a low level language that allows you to 
// direct manipulate the EVM (more dangerous and not recommended)
// EVM = smart contracts are not the real code in the blockchain,
// solidity code is compiled to a loer level language.

contract LearnAssembly{
    function addToEVM() pure external {
        uint x;
        uint y;
        //uint z = x + y ;
        // how do we use assembly?? (opcodes)
        assembly {
            // declares an assembly block
            // inside we can manipulate variables declared outside
            // no semi colon = is actually := and can bring in opcodes
            // it sould be inside function
            let z := add(x, y)
            // we can run "if" "functions" "for"

            // load data from a specific slot
            let a := mload(0x40)

            // store something temporarily to memory
            mstore(a,4)

            // persistance storage!
            //sstore(a,100)
        }
        // In EVM everything is stored in slots of 256 bits (a uint occupies one slot)
        // whereas mapping or array is several
    }
    function addToEVM2() public view returns (bool success){
        uint size;
        address addr;
        // check whether an address contains any bytes of code or not
        assembly {
            size := extcodesize(addr)
        }
        return size>0;
    }
    
}
