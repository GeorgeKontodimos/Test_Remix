// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

// INTERFACES
// Interfaces are similar to abstract contracts using interface keyword.
// Interface CAN NOT have any function with implementation.
// Functions of an interface can be only of type external.
// Interface CAN NOT have constructor.
// Interface CAN NOT have state variables.
// Interface CAN have enum, structs which can be accessed using interface name dot notation.

// EXAMPLE:

contract Counter{
    uint public count;
    function increment() external{count+=1;}
}
// how do we interact with this contract without copy and pasting the code??
// ANSWER -> With an Interface
interface ICounter{
    function increment() external; // can only be of type external. Cannot have internal or private functions in interface
    function count() external view returns(uint);
}

contract MyContract{
    function incrementCounter(address _couner) external{
        ICounter(_couner).increment(); // contract has to implement ICounter interface in order for this to work. 
        // We are calling a method of an interface using the reference of the interface variable (Couner is _counter)
        // In our example, we are just incrementing the count and not changing it. The external function doesn't change the state of the contract but the counter address which implements ICounter can do that. 
    }
    function getCount(address _counter) external view returns(uint){
        return ICounter(_counter).count();
    }
}

interface UniswapV2Factory{
    function getPair(address tokenA, address tokenB) external view returns(address pair);
}

interface UniswapV2Pair{
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract MyContractTwo {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function getReserves() external view returns (uint112, uint112){
        address pair = UniswapV2Factory(factory).getPair(dai,weth);
        (uint112 reserve0, uint112 reserve1,) = UniswapV2Pair(pair).getReserves();
        return (reserve0,reserve1);
    }
}
