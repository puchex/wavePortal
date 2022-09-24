// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal{
    uint totalWaves;

    struct Wave{
        address waver;
        string data;
        uint timestamp;

    } 
    Wave[] waves;

    event newWave(address indexed from , string data, uint timestamp);

    constructor() payable {
        console.log("Im born at last!!, Awesomeness on the way...");
    }

    function wave(string memory data ) public{
        totalWaves += 1;
        console.log(msg.sender, " has just waves **Sigh**, says : ", data);
        waves.push(Wave(msg.sender,data,block.timestamp));
        emit newWave(msg.sender, data, block.timestamp);
	uint256 prize = 0.0001 ether;
	require(
		prize <= address(this).balance,
		"Insufficient balance in contract.. Add funds"
	);
	(bool success, ) = (msg.sender).call{value : prize}("Thanks for waving");
	require(success, "Failed to send money in respone to waving");
    }

    function getAllWaves() public view returns (Wave[] memory){
        return  waves;
    }

    function getTotalWaves() public view returns (uint){
        return totalWaves;
    }
    
}
