pragma solidity ^0.4.12;

contract IRepo {
    function getRelease (bytes32 tag) public view returns (bytes32 commitHash) {}
    function getCommitHashes (bytes32 branch) public view returns (bytes32[] _commitHashes) {}
}