

const ERC20 = artifacts.require('ERC20Token');

const owner = '0x77edd2bdcfea24dfb0db9636777b5cf938736cc0';
const totalSupply = 1000000000;

contract('Distribution', async function ([ourAccount, account0]) {
  const value = 100;

  beforeEach(async function () {
    this.token = await ERC20.new(
      owner,
      totalSupply
    )
  });

  describe('Handling transfer', function () {
    it('should be able to transfer tokens to account', async function () {
      await this.token.transfer(account0, value, {from: ourAccount});
      const tokens = await this.token.balanceOf(account0, {from: ourAccount});
    })
  });
});
