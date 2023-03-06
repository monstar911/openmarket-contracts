// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./UsersStorage.sol";

contract UsersBalance {
    UserStorage userStorage;

    struct DepositInfo {
        uint256 lastDepositTime; //since an hour passed
        uint256 depositsCount;
    }
    
    mapping(string => uint256) public balances;
    mapping(string => DepositInfo) public userDepositInfo;

    uint256 constant public DEPOSIT_LIMIT = 10000; // arbitrary value
    uint256 constant public DEPOSIT_MIN = 200; // arbitrary value
    uint256 constant public DEPOSIT_COST = 0.000005 ether; // arbitrary value
    uint256 constant public WITHDRAW_COST = 0.0002 ether; // arbitrary value
    uint256 constant public DEPOSIT_LIMIT_PER_HOUR = 10;
    uint256 constant public SECONDS_PER_HOUR = 3600;

    event DepositSuccess(string indexed _username, uint256 _amount);
    event WithdrawSuccess(string indexed _username, uint256 _amount);

    constructor(address _userStorage) {
        userStorage = UserStorage(_userStorage);
    }

    function deposit(string memory _username, uint256 _amount) public payable {
	require(msg.value >= DEPOSIT_COST * _amount, "Insufficient payment");
	require(_amount <= DEPOSIT_LIMIT,"Limit amount per deposit exeeded");
	require(_amount >= DEPOSIT_MIN,"Amount must reach the min limit");
    	require(userStorage.userExists(_username),"Invalid User");

	DepositInfo storage info = userDepositInfo[_username];
	uint256 currentTime = block.timestamp;

	if(info.lastDepositTime + SECONDS_PER_HOUR < currentTime){
		//An hour has passed
		info.lastDepositTime = currentTime;
		info.depositsCount = 1;
	}else{
		require(info.depositsCount+1 <= DEPOSIT_LIMIT_PER_HOUR,"Deposit limit reached for this hour");
		info.depositsCount += 1;
	}
	require(info.depositsCount <= DEPOSIT_LIMIT_PER_HOUR,"Deposit limit reached for this hour");

	balances[_username] += _amount;

	emit DepositSuccess(_username, _amount);
    }

    function withdraw(uint256 _amount) public payable {
	require(msg.value >= WITHDRAW_COST, "Insufficient payment");
	UserStorage.User memory user = userStorage.getUser(msg.sender);
	
	require(user.publicKey != address(0), "Invalid user");
	require(msg.sender == user.publicKey, "Invalid user");

	uint256 balance = balances[user.username];
	
	require(balance > _amount, "Insufficient balance");
		
	balances[user.username] -= _amount;
	
	emit WithdrawSuccess(user.username, _amount);
    }

    function getUserBalance(string memory _username) public view returns (uint256) {
    	return balances[_username];
    }
}
