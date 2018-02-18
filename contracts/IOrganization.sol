pragma solidity ^0.4.12;

contract IOrganization {
    event RoleCreated(bytes32 name);
    event RepoCreated(bytes32 name, address repoAddress);
    event Commit(bytes32 commitHashe);
    event Release(bytes32 tag);

    function getRole (bytes32 role) public view returns (bool create, bool release, bool commit, bool merge) {}
    function getRepo (bytes32 name) public view returns (address repo) {}
    function listRepos () public view returns (bytes32[] names) {}
    function getMemberRole(address member) public view returns (bytes32 role) {}
    function createRole (bytes32 role, bool create, bool release, bool commit, bool merge) external {}
    function assignRole (address member, bytes32 role) external {}
    function createRepo (bytes32 name) external {}
    function commit (bytes32 commitHash, string ipfsHash, address repo, bytes32 branch) public {}
    function tagRelease (bytes32 tag, bytes32 commitHash, address repo) public {}
}