pragma solidity ^0.4.12;

contract Repository {
    address public organization;

    struct Commit {
        bytes32 commitHash;
        string ipfsHash;
        address author;
        uint at;
    }

    mapping(bytes32 => bytes32[]) public commitHashes;
    mapping(bytes32 => Commit) public commits;
    mapping(bytes32 => bytes32) public releases;
    bytes32[] tags;

    modifier onlyOrg {
        require(msg.sender == organization);
        _;
    }

    function Repository () public {
        organization = msg.sender;
    }

    // Return tagged releases
    function getTags () public view returns (bytes32[] _tags) {
        return tags;
    }

    // Get a release by tag
    function getRelease (bytes32 tag) public view returns (bytes32 commitHash) {
        return releases[tag];
    }

    // Get commit hashes from branch
    function getCommitHashes (bytes32 branch) public view returns (bytes32[] _commitHashes) {
        return commitHashes[branch];
    }

    // Tag a release to a specific commit hash
    function tagRelease (bytes32 tag, bytes32 commitHash) public onlyOrg {
        // Ensure this commit exists somewhere
        assert(commits[commitHash].at != 0x0);
        for (uint i = 0; i < tags.length; i++) {
            assert(tags[i] != tag);
        }
        releases[tag] = commitHash;
        tags.push(tag);
    }

    // Make a commit
    function commit (bytes32 commitHash, string ipfsHash, bytes32 branch, address author) public onlyOrg {
        // make sure this branch does not already have a commit by this hash
        // for (uint i = 0; i < commitHashes[branch].length; i++) {
            // assert(commitHashes[branch][i] != commitHash);
        // }

        commitHashes[branch].push(commitHash);
        commits[commitHash] = Commit({
            commitHash: commitHash,
            ipfsHash: ipfsHash,
            author: author,
            at: now
        });
    }
}
