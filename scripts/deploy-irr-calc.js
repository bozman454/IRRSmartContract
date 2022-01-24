const hre = require('hardhat');

async function main(){
    const IRR = await hre.ethers.getContractFactory("IRRCalculator");
    const rate = await IRR.deploy(69);

    console.log('deployed to:', rate.address)


}


main()
    .then(()=> process.exit(0))
    .catch((error)=> {
        console.error(error)
        process.exit(1)
    })