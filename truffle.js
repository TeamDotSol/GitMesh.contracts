var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic = "party goose obtain people guitar tail bacon cricket song whip toward giraffe";

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/AQLPHGoZNh6Ktd33vkIg"),
      network_id: 3
    }
  }
};
