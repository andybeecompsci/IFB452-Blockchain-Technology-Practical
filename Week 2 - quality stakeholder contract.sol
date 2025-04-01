// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    address public singleStakeholder;     // eth address of authorized stakeholder
    uint256 public qualityScore;          // stored quality score as state variable

    modifier onlyStakeholder() {          // only stakeholder can execute restricted functions
        require(msg.sender == singleStakeholder, "Only the stakeholder can execute this");
        _;
    }

    event QualityScoreUpdated(uint256 newScore);     // allows logging score updates to the blockchain

    constructor(address stakeholderAddress) {        // set stakeholder address during deployment
        require(stakeholderAddress != address(0), "Invalid stakeholder address");
        singleStakeholder = stakeholderAddress;
        qualityScore = 0;    // initialize score to 0
    }

    function updateQualityScore(uint256 newScore) external onlyStakeholder {
        // allows stakeholder to update the product quality score, external saves gas
        qualityScore = newScore;
        emit QualityScoreUpdated(newScore);     // trigger to log the new quality score
    }
}
