pragma solidity ^0.4.12;

contract IOrganization {
    function getRole (bytes32 role) public view returns (bool create, bool release, bool commit, bool merge) {}
    function getRepo (bytes32 name) public view returns (address repo) {}
    function listRepos () public view returns (bytes32[] names) {}
    function getRelease (address repo, bytes32 tag) public view returns (bytes32 commitHash) {}
    function createRole (bytes32 role, bool create, bool release, bool commit, bool merge) external {}
    function assignRole (address member, bytes32 role) external {}
    function createRepo (bytes32 name) external {}
    function commit (bytes32 commitHash, string ipfsHash, address repo, bytes32 branch) public {}
    function tagRelease (bytes32 tag, bytes32 commitHash, address repo) public {}
}