//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

	uint256 public constant MINUMUM_USD = 5e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor() {
    i_owner = msg.sender;
    }

	function fund() public payable greaterTahnMinimumUsd {
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
	}

	function withdraw() public onlyOwner {
			for (uint256 i = 0; i < funders.length; i++) {
					addressToAmountFunded[funders[i]] = 0;
			}

			funders = new address[](0);

			(bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
			require(callSuccess, "Call failed");
	}

	receive() external payable {
		fund();
	}

	fallback() external payable {
		fund();
	}

	modifier onlyOwner() { 
		require(msg.sender != i_owner, "You are not the owener of the contract!!!");
		_;
	}

	modifier greaterTahnMinimumUsd() {
		require(msg.value.getConversionRate() >= MINUMUM_USD, "You need to spend more ETH!");
		_;
	}
}


