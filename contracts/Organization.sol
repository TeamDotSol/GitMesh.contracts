pragma solidity ^0.4.12;

import "./Repo.sol";

contract Organization {
    // ----------------------------------------------
    // ---------------- Globals ---------------------
    // ----------------------------------------------

    address public owner;

    // Permissions role
    struct Role {
        bytes32 name;
        bool create;
        bool release;
        bool commit;
        bool merge;
    }

    // Available roles in the system
    mapping(bytes32 => Role) roles;
    // Assigned roles to the members
    mapping(address => bytes32) members;
    
    // Repo tracking
    mapping(bytes32 => address) repos;
    bytes32[] repoNames;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function Organization () public {
        owner = msg.sender;
    }

    // ----------------------------------------------   
    // ------------ Getter Functions ----------------
    // ----------------------------------------------

    function getRole (bytes32 role) public view returns (bool create, bool release, bool commit, bool merge) {
        Role memory r = roles[role];

        return (
            r.create,
            r.release,
            r.commit,
            r.merge
        );
    }

    // Get a repo address by name
    function getRepo (bytes32 name) public view returns (address repo) {
        return repos[name];
    }

    // Get a list of repo names
    function listRepos () public view returns (bytes32[] names) {
        return repoNames;
    }


    // ----------------------------------------------   
    // ------------ Public Functions ----------------
    // ----------------------------------------------

    // Add or update a role
    function createRole (bytes32 role, bool create, bool release, bool commit, bool merge) external onlyOwner {
        roles[role] = Role({
            name: role,
            create: create,
            release: release,
            commit: commit,
            merge: merge
        });
    }

    // Assign a role to a user
    function assignRole (address member, bytes32 role) external onlyOwner {
        assert(roles[role].name != 0x0);

        members[member] = role;
    }

    // Add a new repo to the org
    function createRepo (bytes32 name) external {
        Role memory senderRole = roles[members[msg.sender]];

        assert(senderRole.create);
        assert(repos[name] == 0x0);

        repos[name] = new Repo();
        repoNames.push(name);
    }

    // Make a commit (proxied through for permissions)
    function commit (bytes32 commitHash, string ipfsHash, address repo) public {
        Role memory senderRole = roles[members[msg.sender]];

        assert(senderRole.commit);

        Repo(repo).commit(commitHash, ipfsHash);
    }

    // Tag a release to a specific commit hash (proxied through for permissions)
    function tagRelease (bytes32 release, bytes32 commitHash, address repo) public {
        Role memory senderRole = roles[members[msg.sender]];

        assert(senderRole.release);

        Repo(repo).tagRelease(release, commitHash);
    }
}