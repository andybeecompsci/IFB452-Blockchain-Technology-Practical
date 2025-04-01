// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    //owner of the contract
    address public owner;

    //structure for each quality contract
    struct QualityContractData {
        string contractName; //name of the contract
        address[] stakeholders; //who can verify the contract
        string qualityCriteria; //description of quality standards
        bool isCompleted; //status of the contract
    }

    //stores contracts by id
    mapping (uint256 => QualityContractData) public qualityContracts;

    //tracks how many contracts exist
    uint256 public contractCount;

    //logs when a new contract is created
    event QualityContractCreated(uint256 contractId, string contractName, address[] stakeholders, string qualityCriteria);

    //set deployer as owner
    constructor() {
        owner = msg.sender;
    }

    //limits access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    //create a new contract and save it
    function createQualityContract(string memory _contractName, address[] memory _stakeholders, string memory _qualityCriteria) public onlyOwner {
        contractCount++; //generate new id
        qualityContracts[contractCount] = QualityContractData(_contractName, _stakeholders, _qualityCriteria, false);
        emit QualityContractCreated(contractCount, _contractName, _stakeholders, _qualityCriteria);
    }

    //mark a contract as complete
    function completeQualityContract(uint256 _contractId) public onlyOwner {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        qualityContracts[_contractId].isCompleted = true;
    }

    //return full details of a contract
    function getQualityContractDetails(uint256 _contractId) public view returns (string memory, address[] memory, string memory, bool) {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        QualityContractData storage contractData = qualityContracts[_contractId];
        return (
            contractData.contractName,
            contractData.stakeholders,
            contractData.qualityCriteria,
            contractData.isCompleted
        );
    }

    //let stakeholders simulate a check and mark complete
    function performQualityCheck(uint256 _contractId) public {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");

        //verify caller is a stakeholder
        bool isStakeholder = false;
        for (uint i = 0; i < qualityContracts[_contractId].stakeholders.length; i++) {
            if (qualityContracts[_contractId].stakeholders[i] == msg.sender) {
                isStakeholder = true;
                break;
            }
        }

        require(isStakeholder, "Only stakeholders can perform quality check");

        //mark as complete
        qualityContracts[_contractId].isCompleted = true;
    }
}
