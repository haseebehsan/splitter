var Splitter = artifacts.require("./Splitter.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(Splitter);
};
