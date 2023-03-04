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

# Reference
Most of base knowledge to build this is based on official Polygon docs:
[Polygon Hardhat] (https://wiki.polygon.technology/docs/develop/hardhat)

ChatGPT helped with the official docs unclear topics
