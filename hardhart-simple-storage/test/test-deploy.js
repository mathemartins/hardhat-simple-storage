const hre = require("hardhat");
const {expect, assert} = require("chai");

describe("SimpleStorage", function() {
    let simpleStorageFactory, simpleStorage;

    beforeEach(async function() {
        simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
        simpleStorage = await simpleStorageFactory.deploy();
    })

    it("Should start with a favorite number of 0", async function () {
        const currentValue = await simpleStorage.retrieveFavoriteNumber()
        const expectedValue = "0";
        // assert
        // expect
        assert.equal(currentValue.toString(), expectedValue);
        // expect( currentValue.toString()).to.equal(expectedValue);
    })

    it("Should update our favorite number to 7", async function () {
        const expectedValue = "7";
        const transactionResponse = await simpleStorage.storeFavoriteNumber(expectedValue);
        await transactionResponse.wait(1);
        // assert
        // expect

        const currentValue = await simpleStorage.retrieveFavoriteNumber();
        assert.equal(currentValue.toString(), expectedValue)
    })
})