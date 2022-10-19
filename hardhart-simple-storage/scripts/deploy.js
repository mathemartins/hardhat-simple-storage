const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;
  const lockedAmount = hre.ethers.utils.parseEther("1");
  const Lock = await hre.ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });
  await lock.deployed();
  console.log(
    `Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
  );

  const simpleStorageFactory = await hre.ethers.getContractFactory("SimpleStorage");
  console.log("Deploy contract...");
  const simpleStorage = await simpleStorageFactory.deploy()
  await simpleStorage.deployed()
  console.log(`Deployed contracts to ${simpleStorage.address}`);

  if (hre.network.config.chainId === 5 && process.env.ETHERSCAN_API_KEY) {
    await simpleStorage.deployTransaction.wait(6);
    verify(simpleStorage.address, []);
  }
}

async function verify(contractAddress, args) {
  console.log("Verifying contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: args
    })
  } catch (error) {
    if (error.message.toLowerCase().includes("already verified")) {
      console.log("Already Verified!");
    } else {
      console.log(error);
    }
  }
  

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
