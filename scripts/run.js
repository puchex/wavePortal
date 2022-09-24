const main = async () => {
    const signers = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
				value : hre.ethers.utils.parseEther("0.1"),
		});
    await waveContract.deployed();
    console.log("Contract deployed at : ", waveContract.address);
    console.log("wavePortal contract deployed by :",signers[0].address);

		let contractBalance = await hre.ethers.provider.getBalance(
			waveContract.address
		);
		
		console.log("Contract balance : ", hre.ethers.utils.formatEther(contractBalance));
    let waveCount = await waveContract.getTotalWaves();
    let j = Math.floor(Math.random()*(1+signers.length));
    let cnt = Math.floor(Math.random()*(31));
    
    for(let i = 0 ; i < signers.length;i++){

    let waveTxn = await waveContract.connect(signers[i]).wave(`Random${i}Message`);
    await waveTxn.wait();
    if(i==j){
    for(let k =0;k<cnt;k++){
    waveTxn = await waveContract.connect(signers[i]).wave(`Random${i} : ${k}Message`);
    await waveTxn.wait();
    }
    }

      waveCount = await waveContract.getTotalWaves();
    }

    console.log("Finally........ \n\n\n");
		contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
		console.log("Current balance is ", hre.ethers.utils.formatEther(contractBalance));
};

const runMain = async () => {
    try{
        await main();
        process.exit(0);
    }
		catch(err){
        console.log(err);
        process.exit(1);
    }
};

runMain();
