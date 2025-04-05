pragma solidity ^0.8.4;

// SPDX-License-Identifier: GPL-3.0

/*
It is time to test your skills and the knowledge you have gained going through this course from start to finish!

Your mission is to write a decentralized auction DApplication which can at the minimum have the following functionality.
As long as you meet the minimum required functionality then you have passed this course with flying colors, however should you choose to exceed
the minimum and continue to expand upon the Auction then you are truly becoming a defi super star and I would love to see what you 
come up with so please share it in the discord! 

If you fall short - do not worry, take your time, ask questions in our Discord, do some research, and go as far as you can. And when you 
are ready go to the solution video and we can go through it all together as always. 

Final Exercise: Create an Auction DApplication (The Decentralized Ebay)

1. You must create a contract called auction which contains state variables to keep track of the beneficiary (auctioneer), 
the highest bidder, the auction end time, and the highest bid. 

2. There must be events set up which can emit whenever the highest bid changes both address and amount and an 
event for the auction ending emitting the winner address and amount. 

3. The contract must be deployed set to the beneficiary address and how long the auction will run for. 

4. There should be a bid function which includes at the minimum the following: 

a. revert the call if the bidding period is over.
b. If the bid is not higher than the highest bid, send the money back.
c. emit the highest bid has increased 

4. Bearing in mind the withdrawal pattern, there should be a withdrawal function 
to return bids based on a library of keys and values. 

5. There should be a function which ends the auction and sends the highest bid to 
the beneficiary!

Alirght - so this is your mission - good luck and may the defi be with you! 
*/
// solution by Clarian North
contract Auction{
    address payable public beneficiary;
    uint public auctionEndTime;
    bool ended;

    mapping(address=>uint) pendingReturns;

    // current state of the auction
    address public highestBidder;
    uint public highestbid;

    event highestBidIncreased(address bidder, uint amount);
    event auctionEnded(address winner, uint amount);

    // contract constructor
    constructor (address payable _beneficiary, uint _biddingTime) {
        require(_biddingTime > 0, "Auction time must be greater than 0");
        
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() public payable {
        if(block.timestamp>auctionEndTime) revert("The auction has ended!");  
        if(msg.value<=highestbid) revert("sorry, the bid is not high enough!");
        
        if (highestbid!=0) {
            pendingReturns[highestBidder]+=highestbid;
        }
        highestBidder = msg.sender;
        highestbid = msg.value;
        emit highestBidIncreased(highestBidder, highestbid);
    }
    // widraws bids that were overbid
    function withdraw() public payable returns(bool){
        uint amount = pendingReturns[msg.sender];
        if(amount>0){
            pendingReturns[msg.sender] =0; // reset
        }
        if(!payable (msg.sender).send(amount)) pendingReturns[msg.sender] = amount;
        return true;
    }
    function actionEnd() public{
        if(block.timestamp >= auctionEndTime) revert('the auction has not ended yet!');
        if(ended) revert ('the auction has already ended');
        ended = true;
        emit auctionEnded(highestBidder,highestbid);
        beneficiary.transfer(highestbid);
    }
}

// gemini ai solution
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint a, uint b) internal pure returns (uint) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
        require(b <= a, errorMessage);
        uint c = a - b;
        return c;
    }
}

contract AuctionG {
    using SafeMath for uint;

    address payable public beneficiary;
    address public highestBidder;
    uint public highestBid;
    uint public auctionEndTime;
    bool public ended;

    mapping(address => uint) public pendingWithdrawals;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(address payable _beneficiary, uint _biddingTime) payable {
        require(_biddingTime > 0, "Bidding time must be greater than 0");
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() external payable {
        require(block.timestamp <= auctionEndTime, "Auction has ended.");
        require(msg.value > highestBid, "Bid not high enough.");

        if (highestBidder != address(0)) {
            pendingWithdrawals[highestBidder] = pendingWithdrawals[highestBidder].add(highestBid);
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw() external {
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function auctionEnd() external {
        require(block.timestamp >= auctionEndTime, "Auction not yet ended.");
        require(!ended, "Auction already ended.");

        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }
}