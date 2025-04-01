// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExamScoreContract {
    address public singleStudent;   //eth address of authorized student
    uint256 public examScore;       // stored state    

    modifier onlyStudent() { // only student can execute this
        require(msg.sender == singleStudent, "Only student can execute this");
        _;
    }

    event ExamScoreUpdated(uint256 newScore);       //allows logging to the blockchain

    constructor(address initialStudent) {           // set student address during deployment
        require(initialStudent != address(0), "Invalid initial student address"); 
        singleStudent = initialStudent;
        examScore = 0; //initialize exam score to 0
    }

    function updateScore(uint256 newScore) external onlyStudent {   //allows student to update the score, external saves gas
        examScore = newScore;
        emit ExamScoreUpdated(newScore); //trigger to log the change
    }
}
