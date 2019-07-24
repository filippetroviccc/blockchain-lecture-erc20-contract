pragma solidity ^0.5.0;

import "./Migrations.sol";
import "./IERC20.sol";

contract ERC20Token is IERC20{

    uint256 public supply;

    // 0x13243234.. -> 34392849 BEST TOKENS
    mapping(address => uint256) public balances;

    // A -> "approving" -> B to spend some "value"
    // B is sending from A -> C (transferFrom)
    // ((allowance - > spender) -> tokenOwner) -> value
    mapping(address => mapping(address => uint256)) allowances;

    // gas - how much of proceeds to execute
    // gasPrice - how much we willing for an instance of gas
    // gasPrice * gas

    event Transfer(address from, address to, uint256 tokens);
    event Approve(address owner, address spender, uint256 tokens);

    function totalSupply() external view returns (uint256) { // 0 gas
        return supply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function allowance(address tokenOwner, address spender) external view returns (uint256) {
        return allowances[spender][tokenOwner];
    }

    // we want to send from caller -> to  = value
    // transfer -
    function transfer(address to, uint256 value) external returns (bool success) {
        require(balances[msg.sender] >= value);

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    // tx -> contract
    // failed
    // revert -> my code thrown err
    // require = false  => gas back
    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0));
        require(allowances[spender][msg.sender] == 0);
        require(balances[msg.sender] >= value);

        allowances[spender][msg.sender] = value;

        emit Approve(msg.sender, spender, value);
        return true;
    }

    // approve tokens
    // sending transferFrom
    function transferFrom (address from/*owner*/, address to, uint256 value) external returns (bool) {
        require(allowances[msg.sender][from] >= value);
        require(balances[from] >= value);

        allowances[msg.sender][from] -= value;
        balances[from] -= value;

        balances[to] += value;

        emit Transfer(from, to, value);
        return true;
    }
}

// @TODO COMPILE
// @TODO MIGRATE (deploy on local net, testnet)
// @TODO TESTING
// @TODO CREATING CUSTOM BEST TOKEN
