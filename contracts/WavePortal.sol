// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal{
    uint totalWaves;
    uint256 private seed;
    mapping(address => uint256) public lastWavedAt;
    struct Wave{
        address waver;
        string data;
        uint timestamp;


    } 
    Wave[] waves;

    event newWave(address indexed from , string data, uint timestamp);

    constructor() payable {
        console.log("Im born at last!!, Awesomeness on the way...");
	seed = (block.timestamp + block.difficulty)%100;
    }


    function wave(string memory data ) public{
	require(
		lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
		"Wait 15 minutes"
	);
	lastWavedAt[msg.sender] = block.timestamp;
        totalWaves += 1;
        console.log(msg.sender, " has just waves **Sigh**, says : ", data);
        waves.push(Wave(msg.sender,data,block.timestamp));
        emit newWave(msg.sender, data, block.timestamp);
	uint256 prize = 0.0001 ether;
	seed = (block.timestamp + block.difficulty+seed)%100;
	if(seed < 34){
		console.log("Waver won the prize");
	require(
		prize <= address(this).balance,
		"Insufficient balance in contract.. Add funds"
	);
	(bool success, ) = (msg.sender).call{value : prize}("Thanks for waving");
	require(success, "Failed to send money in respone to waving");
	}
	}


    function getAllWaves() public view returns (Wave[] memory){
        return  waves;
    }

    function getTotalWaves() public view returns (uint){
        return totalWaves;
    }
    
}
