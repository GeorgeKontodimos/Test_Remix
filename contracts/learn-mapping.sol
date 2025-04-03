// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract learnMapping{
    mapping(address=>uint) public myMap;
    function getAddress(address _addr) public view returns(uint){
        return myMap[_addr];
    }
    function addToMyMap(address _add,uint _i)public {
        myMap[_add]=_i;
    }
    function removeFromMyMap(address _remo) public{
            delete myMap[_remo];
    }
    mapping(uint => Movie) movie;
   struct Movie {
        string title;
       string director;
         }
         function addMovie(uint id,string memory _title,string memory _director) public{
              movie[id]=Movie(_title,_director);
           }

    // =================== Nested Mapping ======================
    mapping (address => mapping(uint=>Movie)) public myMovie;
    function addToMyMovie(uint id,string memory _title,string memory _director)public{
        myMovie[msg.sender][id] = Movie(_title,_director);
        // msg.sender is a global variable accessible throughout solidity which captures the address that
        // sent the transaction to this smart contract (will be the person who's currently connecting with the contract.)
        
    }
            /*Let's make it very simple.
            There are two types of accounts in the Ethereum Chain
            1). Externally Owned Accounts(EOA) [Person]
            2). Contracts Accounts [Contracts on Chain]
            Both accounts have their addresses.

            Now, look at an example.
            Wallet address of personA (EOA) is 0x0cE446987406E92DF41614C46F1d6df9Cc925847.

            Contract Address of Math.sol is 0x0cE446987406E92DF41614C46F1d6df9Cc753869 and Math.sol contains ContractA

            Contract Address of Addition.sol is 0x0cE446987406E92DF41614C46F1d6df9Cc357241 and Addition.sol contains ContractB

            Here, one of the functions of ContractB is called from ContractA.

            So, whenever personA calls any functions of ContractA.

            In this scenario, if you print or get `msg.sender` and `tx.origin` inside function of `ContractB` then the result would be like this

            msg.sender = `0x0cE446987406E92DF41614C46F1d6df9Cc753869` // You will get address of `ContractA`
            tx.origin  = `0x0cE446987406E92DF41614C46F1d6df9Cc925847` // personA's (EOA) Wallet A */   

     function getMyMovie(uint _id)public view returns (string memory){
        return myMovie[msg.sender][_id].title;
       }
}