const ERC20 = artifacts.require("ERC20Token");

module.exports = function(deployer) {
  deployer.deploy(ERC20,
    '0x77edd2bdcfea24dfb0db9636777b5cf938736cc0',
    '1000000000000000000000000000000000');
};
