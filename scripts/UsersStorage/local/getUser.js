const Web3 = require("web3");
const contractAddress = process.argv[2];
const contractAbi = require("../../artifacts/contracts/UsersStorage.sol/UserStorage.json").abi;

const web3 = new Web3('http://127.0.0.1:8545');
const userStorage = new web3.eth.Contract(contractAbi, contractAddress);

const userAddress = process.argv[3]; // replace with the address you want to query

userStorage.methods.getUser(userAddress).call((error, result) => {
  if (error) {
    console.error(error);
    return;
  }

  console.log('User:', result);
});

