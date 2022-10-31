// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GrowicPrimitiveDataType {
    // I'm not sure how to check is a key already exists in mapping, so I added property "registered" to help.
    struct studentsDetail{
        uint256 percentage;
        uint256 totalMarks;
        bool registered;
    }

    address public immutable owner;
    mapping (address=>studentsDetail) private studentIDToDetails;

    error NotOwner();
    error studentAlreadyExist();   

    modifier onlyOwner {
        if (msg.sender !=owner) revert NotOwner();
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function register(address studentID,uint256 percentage,uint256 totalMarks) onlyOwner public{
        if(studentIDToDetails[studentID].registered){
            revert studentAlreadyExist();
        }
        studentIDToDetails[studentID].percentage = percentage;
        studentIDToDetails[studentID].totalMarks = totalMarks;
        studentIDToDetails[studentID].registered = true;
    }

    function getStudentDetails(address studentID) public view returns(uint256,uint256){
        return (studentIDToDetails[studentID].percentage,studentIDToDetails[studentID].totalMarks);
    }  
}
