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
        uint a;
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
            a := mload(0x40)

            // store something temporarily to memory
            mstore(a,4)

            // persistance storage!
            sstore(a,100)
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

    function addToEVM3() external pure {
        bytes memory data = new bytes(10);
        // we cannot convert this into in a fixed size
        // bytes dataB32 = bytes32(data);
        // but if we only care about the first 32 bytes we can assembly! ;)
        /* When you have a bytes memory array in Solidity, the first 32 bytes 
        (0x20 in hexadecimal) store the length of the array. The actual data 
        starts after this length prefix. So, we're getting the memory address 
        where the actual byte data begins. This is because each element in Solidity
        array is 32 bytes in size and Solidity arrays are always stored in memory 
        using this standard layout. bytes32 are fixed size and they don't have the
        32 bytes slot associated with the length.
        */
        bytes32 dataB32;
        assembly {
            //data points us - bytes in memory is size so dtat starts at second slot 
            // so we add 32 bytes
            dataB32 := mload(add(data,32))
            // operation add and we add 32 bytes so we fill the first slot
        }
    }
}
// gemini ai
// Reading as uint256 is not possible because of different lengths 
contract ReadBytes32FromBytes {
    function read(bytes memory data, uint256 offset) public pure returns (bytes32 result) {
        // Ensure we don't go out of bounds
        require(offset + 32 <= data.length, "Offset out of bounds");

        assembly {
            // Get the memory address of the bytes array data
            let dataPtr := add(data, 0x20) // Bytes arrays have a 32-byte length prefix

            // Calculate the address of the desired bytes32 value
            let valuePtr := add(dataPtr, offset)

            // Load the 32 bytes into the result variable
            result := mload(valuePtr)
        }
    }
}
/*
Let's break down what's happening in the assembly block:
let dataPtr := add(data, 0x20): When you have a bytes memory array in Solidity,
 the first 32 bytes (0x20 in hexadecimal) store the length of the array. 
 The actual data starts after this length prefix. So, we're getting the memory address 
 where the actual byte data begins.
let valuePtr := add(dataPtr, offset): Now, we take the starting address of the byte data (dataPtr)
 and add the offset you provide. This gives us the exact memory address where the bytes32 value
  you're interested in begins.
result := mload(valuePtr): The mload(address) opcode in EVM assembly loads 32 bytes (which is the size of a bytes32) 
from the memory address specified. We're loading the 32 bytes starting at valuePtr and storing them directly into our result variable.
How to use it:
You'd call the read function with the bytes array you have and the offset (in bytes) 
from where you want to start reading the bytes32.
Important Considerations:
Bounds Checking: The require statement outside the assembly block is crucial 
for preventing out-of-bounds reads, which can lead to unexpected behavior or security vulnerabilities.
Memory Layout: This code assumes the standard memory layout of a bytes array in Solidity.
Efficiency: Using assembly can be more gas-efficient for certain low-level operations,
 but it also requires a deeper understanding of the EVM.
Let me know if you'd like to explore other assembly tricks or have more questions!
*/


contract StorageWriter {
    function writeStorage(uint256 slot, bytes32 value) public {
        assembly {
            sstore(slot, value)
        }
    }
}