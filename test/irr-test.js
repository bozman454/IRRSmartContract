const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("IRRCalculator", function () {
    it("Should return the number 69", async function () {

        const IRR = await hre.ethers.getContractFactory("IRRCalculator");

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

        const irrrate = 20
        
        const scale = 10000

        var newValues = [];
        values.map( v => newValues.push(v * scale))
        const rate = await IRR.deploy(irrrate, values);

        await rate.deployed();
        expect(await rate.getIRR() / Math.pow(10, 24)).to.equal(10);
        
    })
}) 