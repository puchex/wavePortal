// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal{
    uint256 totalWaves;
    mapping (address => uint) wavesCount;
    struct Waver{
        address addr;
        uint waves;
    }
    Waver[10] public top10;

    string[] messages;
    constructor(){
        console.log("I am WavePortal... Just born as a smart contract");
    }
    function wave(string calldata data) public {
        totalWaves += 1;
        messages.push(data);
        wavesCount[msg.sender] += 1;
        updateTop10(msg.sender, wavesCount[msg.sender]);
        console.log("%s has waved hi.. Saying %s..", msg.sender,data);
    
    }

    function updateTop10(address addr, uint val) private {
        uint i = 0;
        for(i=0;i<10;i++){
            if(top10[i].waves < val){
                break;
            }
        }
        for(uint j = i;j<9;j++){
            top10[j+1] = top10[j];
        }
        if(i<10){
        top10[i].addr = addr;
        top10[i].waves = val;
        }
    }
    function topWaver() public view returns (address){
        console.log("%s waved at you %d times... Is he your best friend??",top10[0].addr,top10[0].waves);
        return top10[0].addr;
    }
    function getTotalWaves() public view returns (uint256){
        console.log("%d girls waved at you!!",totalWaves);
        return totalWaves;
    }
}