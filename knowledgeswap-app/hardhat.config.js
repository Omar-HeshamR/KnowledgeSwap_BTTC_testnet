require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-etherscan');

const dotenv = require("dotenv");
dotenv.config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  allowUnlimitedContractSize: true,
  networks: {
    goerli: {
      url: process.env.GOERLI_INFURA_KEY,
      accounts: [process.env.PRIVATE_KEY],
      allowUnlimitedContractSize: true,
    },
},  
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY,
  },
};
