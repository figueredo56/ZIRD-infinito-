// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;



interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

}



contract ZAIRD is IERC20 {

    string public name = "ZAIRD";

    string public symbol = "ZAIRD";

    uint8 public decimals = 18;

    uint256 public override totalSupply = 100 * 10**18; // Exactly 100 tokens

    

    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;



    constructor() {

        balanceOf[msg.sender] = totalSupply;

        emit Transfer(address(0), msg.sender, totalSupply);

    }



    function transfer(address recipient, uint256 amount) public override returns (bool) {

        require(balanceOf[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");

        balanceOf[msg.sender] -= amount;

        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);

        return true;

    }



    function approve(address spender, uint256 amount) public override returns (bool) {

        allowance[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;

    }



    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {

        require(balanceOf[sender] >= amount, "ERC20: transfer amount exceeds balance");

        require(allowance[sender][msg.sender] >= amount, "ERC20: transfer amount exceeds allowance");

        

        balanceOf[sender] -= amount;

        balanceOf[recipient] += amount;

        allowance[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);

        return true;

    }

}
