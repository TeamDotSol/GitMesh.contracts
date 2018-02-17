const Repo = artifacts.require("./Repo.sol")
const Organization = artifacts.require("./Organization.sol")

module.exports = function(deployer) {
  deployer.deploy(Organization)
  deployer.deploy(Repo)
  deployer.link(Organization, Repo)
}
