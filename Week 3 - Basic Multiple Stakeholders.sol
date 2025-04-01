// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    mapping(address => bool) public stakeholders; //tracks which addresses are stakeholders (true means theyre stakeholders, false means they're not)
    uint256 public qualityScore; //represents current quality score

    modifier onlyStakeholder() {        //checks if caller = stakeholder
        require(stakeholders[msg.sender], "Only stakeholder can execute this");
        _;
    }

    constructor(address[] memory initialStakeholders) {     //take array of addresses as input
        for (uint256 i = 0; i < initialStakeholders.length; i++) {  //loop through each address and set it to be a stakeholder
            stakeholders[initialStakeholders[i]] = true;
        }
        qualityScore = 0;   //init as 0
    }

    function updateQualityScore(uint256 newScore) external onlyStakeholder {    //set new quality score
        qualityScore = newScore;
    }

    function addStakeholder(address newStakeholder) external onlyStakeholder {  //add stakeholder
        stakeholders[newStakeholder] = true;
    }
}
