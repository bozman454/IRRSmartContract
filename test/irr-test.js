const { expect } = require("chai");
const { ethers } = require("hardhat");
const truffleAssert = require('truffle-assertions')

const values = [
    -100.00,
    14.00,
    25.00,
    16.00,
    12.00,
    79.00,
    36.00,
    42.00
];

//scaled percentage
const irrrate = 19883        
const role = "financial analyst"


describe("IRRCalculator", function () {
    it("Should return the number correct IRR guess (.00151857)", async function () {
        const IRR = await hre.ethers.getContractFactory("IRRCalculator");
        const rate = await IRR.deploy(irrrate, values, role);
        await rate.deployed();
        expect(await rate.irr() / Math.pow(10, 5)).to.equal(.00151857);
    })
}) 

describe("IRRCalculator", function (){
    it("Should break becuase bad input", async function (){
        
        const IRR = await hre.ethers.getContractFactory("IRRCalculator");
        await truffleAssert.reverts(IRR.deploy(irrrate, [], role),
         'Values entered cannot be empty');
        
    })
})


describe("IRRCalculator", function (){
    it("Should break becuase bad role", async function () {
        const IRR = await hre.ethers.getContractFactory("IRRCalculator");
        
        const rate = await IRR.deploy(irrrate, values, "Cashier");
        await rate.deployed();
        await truffleAssert.reverts(rate.irr(),
        'Only financial analyists can access this interface');
    })
})
