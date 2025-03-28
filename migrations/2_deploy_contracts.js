const Voting = artifacts.require("Voting");

module.exports = function (deployer) {
  const candidateNames = ["Candidate 1", "Candidate 2", "Candidate 3"]; // 确保数组不为空
  deployer.deploy(Voting, candidateNames);
};