// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GrowicModifiers {

    uint256 private constant Fee = 100;
    address public immutable owner;
    mapping(address=>UserDetail) private userToUserDetail;
    address[] public users;

    error AmountTooSmall();
    error useDepositInstead();
    error notOwner();
    error useAddFundInstead();

    struct UserDetail {
        string name;
        uint256 age;
        uint256 amount;
        bool registered;
    }

    constructor(){
        owner = msg.sender;
    }

    modifier minimumFee(uint256 _value){
        if(_value<Fee) revert AmountTooSmall();
        _;
    }

    modifier onlyOwner{
        if(msg.sender !=owner) revert notOwner();
        _;
    }


    function deposit () payable public {
        if(userToUserDetail[msg.sender].amount>0) revert useAddFundInstead(); 
        userToUserDetail[msg.sender].amount = msg.value;
        if(!userToUserDetail[msg.sender].registered){
            users.push(msg.sender);
        }
        
    }
    function checkBalance(address user) public view returns(uint256){ 
        return userToUserDetail[user].amount;
    }

    function setUserDetails(string memory name, uint256 age) public {
        userToUserDetail[msg.sender].name = name;
        userToUserDetail[msg.sender].age = age;
        if(!userToUserDetail[msg.sender].registered){
            users.push(msg.sender);
        }
    }

    function getUserDetail() public view returns(string memory ,uint256){
        return (userToUserDetail[msg.sender].name, userToUserDetail[msg.sender].age);
    }

    function addFund() public minimumFee(msg.value) payable {
        if(userToUserDetail[msg.sender].amount==0) revert useDepositInstead();
        userToUserDetail[msg.sender].amount=userToUserDetail[msg.sender].amount + msg.value;
    }

    function withDraw() public onlyOwner {
        // after withDrawing all the money, set everyone's amount to 0
        for(uint256 index=0;index<users.length;index++){
            address userAddress = users[index];
            userToUserDetail[userAddress].amount = 0;
        }
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdraw failed");
    }

}
