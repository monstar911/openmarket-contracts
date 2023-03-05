# OpenMarket Contracts
We use Hardhat to develop, test & deploy the contracts to matic network

Until now we have configured only Mumbai testnet (the default is local btw)

# Contracts
Due default network is set to local, you need to run `npx hardhat node` in background in order to test

To compile contracts under `/contracts` folder run:
```sh
npx hardhat compile
```

To run tests on `/test` folder run:
```sh
npx hardhat test
```
_* You can add --network {network} to change the default network which will run the tests_

# Step By Step
To setup everything:
`npm i`

To start local development:
`npx hardhat node`

To deploy a contract:
`npx hardhat run scripts/deploy.js --network localhost`
_Pending to receive via paramenters: network, address private key, pubkey, contract_

## UserStorage
This contracts is the user database, with the following features (intention):
* Registering
* 1 user per address
* Unique username
* Update user data
* Get User
* Get all registered addresses (only owner)


### Scripts UserStorage
registerUser: `node scripts/local/registerUser.js 0x5fbdb2315678afecb367f032d93f642f64180aa3 "Doe"`

getUser: `node scripts/local/getUser.js 0x5fbdb2315678afecb367f032d93f642f64180aa3 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`

_The given addresses are from local node accounts, in this case are those because i used the accounts[0]_


# Notes
* When testing the contract on local node ethers library will give you access to the accounts initialized for development (you can see this in action by reviewing the scripts in `/scripts` folder)


# Reference
Most of base knowledge to build this is based on official Polygon docs:
[Polygon Hardhat] (https://wiki.polygon.technology/docs/develop/hardhat)

ChatGPT helped with the official docs unclear topics
