import * as dotenv from "dotenv";

import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";

import "hardhat-contract-sizer";
import "hardhat-gas-reporter"
import "hardhat-docgen"
import "solidity-coverage"

dotenv.config();

const accounts = process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [];

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: "0.8.4",
  
  networks: {
    bsc: {
      url: "https://bsc-dataseed.binance.org",
      accounts,
      chainId: 56,
    },
    "bsc-testnet": {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      accounts,
      chainId: 97,
      gasMultiplier: 2,
    },
    "selendra-testnet": {
      url: "https://rpc.testnet.selendra.org",
      accounts,
      chainId: 222,
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
  docgen: {
    path: './docs',
    clear: true,
  }
};

export default config;
