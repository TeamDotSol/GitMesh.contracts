pragma solidity ^0.4.12;

contract Repo {
    address public organization;

    mapping(bytes32 => string) commits;
    mapping(bytes32 => bytes32) releases;

    modifier onlyOrg {
        require(msg.sender == organization);
        _;
    }

    function Repo () {
        organization = msg.sender;
    }

    // Tag a release to a specific commit hash
    function tagRelease (bytes32 release, bytes32 commitHash) public onlyOrg {
        assert(bytes(commits[commitHash]).length != 0);
        releases[release] = commitHash;
    }

    // Make a commit
    function commit (bytes32 commitHash, string ipfsHash) public onlyOrg {
        assert(bytes(commits[commitHash]).length == 0);
        commits[commitHash] = ipfsHash;
    }
}