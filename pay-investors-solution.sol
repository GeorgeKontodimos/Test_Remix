// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 < 0.9.0;

contract AddressWallets {
    
    address payable[] public investorWallets; 
    
    mapping(address => uint) investors;

    event InvestorAdded(address indexed wallet, uint amount);
    event PaymentSent(address indexed wallet, uint amount);
    
    function addInvestor(address payable wallet, uint amount) public {
        require(investors[wallet] == 0, "Investor already exists.");
        investorWallets.push(wallet);
        investors[wallet] = amount;
        emit InvestorAdded(wallet, amount);
    }
    function sendPayment(address payable recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient Ether sent.");
        (bool success, ) = recipient.call{value: amount}("");  // A low-level call to send Ether, along with error handling.
        require(success, "Payment failed.");
        emit PaymentSent(recipient, amount);
    }

    function getInvestorCount() public view returns (uint) {
        return investorWallets.length;
    } 

    function getInvestorAmount(address wallet) public view returns (uint) {
        return investors[wallet];
    } 
    function getValidatorAddress()public view returns (address) {
        return block.coinbase;
    }
}
