const Repository = artifacts.require("./Repository.sol")
const Organization = artifacts.require("./Organization.sol")

module.exports = function(deployer) {
  deployer.deploy(Repository)
  deployer.link(Repository, Organization)
  deployer.deploy(Organization)
}
