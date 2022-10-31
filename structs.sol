// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GrowicStructs {

    struct UserDetail {
        string name;
        uint256 age;
    }

    mapping (address=>uint256) private userToAmount;
    mapping(address=>UserDetail) private userToUserDetail;

    function deposit (uint256 amount) public {
        userToAmount[msg.sender] = amount;
    }
    function checkBalance(address user) public view returns(uint256){ 
        return userToAmount[user];
    }

    function setUserDetails(string calldata name, uint256 age) public {
        userToUserDetail[msg.sender].name = name;
        userToUserDetail[msg.sender].age = age;
    }
    function getUserDetail() public view returns(string memory ,uint256){
        return (userToUserDetail[msg.sender].name, userToUserDetail[msg.sender].age);
    }
}
