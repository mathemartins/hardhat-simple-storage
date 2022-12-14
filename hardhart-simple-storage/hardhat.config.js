require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("./tasks/block-number");
require("hardhat-gas-reporter");
require("solidity-coverage");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    goerli: {
      url: process.env.RPC_SERVER || "https://some-endpoint",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 5
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      // accounts: Thanks hardhat,
      chainId: 31337
    }
  },
  solidity: "0.8.7",
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY || "some-api-key"
  },
  gasReporter: {
    enabled: true,
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    token: "MATIC",
  }
};
