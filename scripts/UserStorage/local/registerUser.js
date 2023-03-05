const { ethers } = require("hardhat");
const Web3 = require("web3");
const contractABI = require("../../artifacts/contracts/UsersStorage.sol/UserStorage.json").abi;

// Connect to the local Hardhat network
const web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));

async function main() {

	// Set up the account to use for the transaction
	const [account] = await ethers.getSigners();
	const privateKey = account.privateKey;
	const publicKey = account.address;

	// Load the contract using the ABI and contract address
	const contractAddress = process.argv[2]; // Replace with the contract address deployed on your local network
	const contract = new web3.eth.Contract(contractABI, contractAddress);

	// Hash the username
	const username = process.argv[3];

	// Call the registerUser function
	const registrationCost = "500000000000000"; // 0.0005 ETH in wei
	await contract.methods.registerUser(username).send({ from: publicKey, value: registrationCost });

	console.log("User registered");
}

main();
