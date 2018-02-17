pragma solidity ^0.4.12;

import "./Repo.sol";

contract Organization {
    address public owner;

    // Permissions role
    struct Role {
        bytes32 name;
        bool create;
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

    // Get a repo address by name
    function getRepo (bytes32 name) public returns (address repo) {
        return repos[name];
    }

    // Get a list of repo names
    function listRepos () public returns (bytes32[] names) {
        return repoNames;
    }

    // Add or update a role
    function createRole (bytes32 role, bool create, bool commit, bool merge) external onlyOwner {
        roles[role] = Role({
            name: role,
            create: create,
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
}