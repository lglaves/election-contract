require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');
const infuraKey = process.env["ENDPOINT_KEY"];
const mnemonic = process.env["NEMONIC"]

module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        },
        buddy: {
            host: "ganache",
            port: 8545,
            network_id: "*" // Match any network id
        },
        rinkeby: {
            provider: () => new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/v3/" + infuraKey),
            network_id: 4,       // Rinkeby's id
            gas : 6700000,
            gasPrice : 10000000000
          },
    }
};



