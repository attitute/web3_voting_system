// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// contract SimpleContract {
//     uint256 public value;

//     function setValue(uint256 _value) public {
//         value = _value;
//     }
// }

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable {
    struct Candidate { // 候选人信息
        uint256 id; // 候选人ID
        string name; // 候选人姓名
        uint256 voteCount; // 候选人得票数
    }

    mapping(uint256 => Candidate) public candidates; // 通过ID获取候选人信息
    uint256 public candidatesCount; // 候选人数量
    mapping(address => bool) public voters; // 记录投票人

    event VotedEvent(uint256 indexed candidateId);

    constructor(string[] memory candidateNames) Ownable(msg.sender) { // 初始化候选人信息
        for (uint256 i = 0; i < candidateNames.length; i++) {
            addCandidate(candidateNames[i]);
        }
    }

    function addCandidate(string memory name) private {
        candidatesCount++; // 计算候选人数量
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0); // 添加候选人信息
    }

    function vote(uint256 candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate ID.");

        voters[msg.sender] = true; // 记录投票人
        candidates[candidateId].voteCount++; // 增加候选人得票数

        emit VotedEvent(candidateId);
    }
}

