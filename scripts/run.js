const main = async () => {
    const signers = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed at : ", waveContract.address);
    console.log("wavePortal contract deployed by :",signers[0].address);

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
    waveTxn = await waveContract.getAllWaves();
    console.log(waveTxn);

};

const runMain = async () => {
    try{
        await main();
        process.exit(0);
    }
    catch(error){
        console.log(err);
        process.exit(1);
    }
};

runMain();