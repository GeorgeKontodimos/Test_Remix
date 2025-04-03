// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
contract conversions {
// ========================= uint =======================
    uint32 a  = 0x12345978;
    uint16 b = uint16(a); // b = 0x5678 conversion to smaller type costs loose higher order bits
    uint16 c = 0x1234;
    uint32 d = uint32(c); // d = 0x00001234 conversion to higher type adds pading bits to the left.
// ========================= bytes =======================
bytes2 e = 0x1234;
bytes1 f = bytes1(f); // f =0x12 conversion to smaller bytes costs loose higher order data
bytes2 g = 0x1234;
bytes4 h = bytes4(g); // h= 0x1234000 conversion to larger bytes adds pading bits to the right.

}