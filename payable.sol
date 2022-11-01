// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract GrowicPayable{
    
    error ExceedWithdrawLimit();
    mapping (address=>uint256) private userToAmount;

    function deposit () public payable {
        userToAmount[msg.sender] =msg.value;
    }
    function checkBalance() public view returns(uint256){ 
        return userToAmount[msg.sender];
    }
    function withDraw(uint256 amount) public {
        if (userToAmount[msg.sender] <amount) revert ExceedWithdrawLimit();    
        (bool success,) = msg.sender.call{value:amount}("");
        require(success, "Call failed");
        userToAmount[msg.sender ] = userToAmount[msg.sender ]-amount;
    }
}
