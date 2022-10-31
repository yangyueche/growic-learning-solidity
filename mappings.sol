// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract GrowicMappings{
    mapping (address=>uint256) private userToAmount;

    function deposit (uint256 amount) public {
        userToAmount[msg.sender] = amount;
    }
    function checkBalance(address user) public view returns(uint256){ 
        return userToAmount[user];
    }
}
