require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy")
require("@chainlink/env-enc").config()

const PRIVATE_KEY_1 = process.env.PRIVATE_KEY_1;
const PRIVATE_KEY_2 = process.env.PRIVATE_KEY_2;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: "",
      accounts: [PRIVATE_KEY_1, PRIVATE_KEY_2],
    }
  },
  namedAccounts: {
    firstAccount: {
      default: 0
    },
    secondAccount: {
      default: 1
    }
  }
};
