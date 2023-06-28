require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hedera",
  networks: {
    hardhat: {
    },
    hedera: {
      url: "https://testnet.hashio.io/api",
      accounts: ["0xf6bfc0c96b7df72231e478345484d1ae1eafb3a5df48124fb396393625b4a0e4"]
    }
  },
  solidity: "0.8.9",
};
