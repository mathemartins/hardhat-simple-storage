// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Get funds from users
// Withdraw funds
// set a minimum funding value in USD

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public  addressToAmountFunded;

    // saves more gas and used cos the varaible does not change
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    // payable is what makes us be able to send money on a function
    // msg and msg.value is a global keyword and can be accessed from anywhere
    function fund() public payable {
        // set a minimum fund amount to be 1 eth
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough eth sent"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    
    function withdraw() public onlyOwner {
    
        // to use a for-loop (startingIndex, endingIndex, step)
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset funders array
        funders = new address[](0);

        // send the money in the smart contract out to transfer out we need the address to be payable
        // msg.sender = address, payable(msg.sender) = payable address
        // TRANSFER -> will fail if the gas price is above 21000, 23000 which makes it a complex algorithm
        // because the computation is done from a smart contract
        // payable (msg.sender).transfer(address(this).balance);
        // SEND -> will fail just like the above and will terminate the rest of the code with a return message
        // therebye avoiding further gas consumption with an error message
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        // CALL -> returns a tuple of data but will go if the gas price is above the base above
        // because it is actually not performing a transfer but calling the function and is ready
        // to consume gas fee required by the function in the smart contract
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner {
        // require(msg.sender == owner, "Owner only");
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _; // rest of the code to execute
    }

    // receive function -> when a native token is sent to a smart contract balance
    // the smart contract updates the balance and calls a receive function(special)
    // once received is called 
    receive() external payable {
        fund();
    }
    // fallback function is called if the call data does not contain any function in the smart contract
    // hence it resolves to calling the fallback function
}