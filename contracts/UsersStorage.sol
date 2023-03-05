// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract UserStorage {
    // Define a struct to store user data
    struct User {
        string username;
        address publicKey;
    }

    address public owner;

    mapping(address => User) public users;
    mapping(string => bool) public usernamesTaken;
    address[] public pubKeys;

    event UserRegistered(string username, address publicKey);
    event UserUpdated(string username, address publicKey);

    uint256 constant public REGISTRATION_COST = 5*10**14; // 0.0005 ether 
    uint256 constant public UPDATE_COST = 2*10**14; // 0.0002 ether
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerUser(string memory _username) public payable {
	require(msg.value >= REGISTRATION_COST, "Insufficient payment");
        require(users[msg.sender].publicKey == address(0), "User already exists");
        require(usernamesTaken[_username] == false, "Username already taken");

        User memory newUser = User(_username, msg.sender);

        users[msg.sender] = newUser;

        usernamesTaken[_username] = true;
	
	pubKeys.push(msg.sender);

        emit UserRegistered(_username, msg.sender);
    }

    function updateUser(/*Data*/) public payable {
         require(msg.value >= UPDATE_COST , "Insufficient payment"); 

         User storage currentUser = users[msg.sender]; 
	 
	 /*
	   Example update
           currentUser.email = _email; 
           currentUser.age = _age; 
	 */

	 emit UserUpdated(currentUser.username, currentUser.publicKey); 
    }

    // return all public keys Only enabled for the owner
    function getPubKeys() public onlyOwner view returns (address[] memory) {
        return pubKeys;     
    }

    function getUser(address _userAddress) public view returns (User memory) {
        return users[_userAddress];
    }
}
