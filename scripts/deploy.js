const { ethers } = require("hardhat");

async function main() {
  const UserStorage = await ethers.getContractFactory("UserStorage");
  const userStorage = await UserStorage.deploy();
  await userStorage.deployed();

  console.log("UserStorage deployed to:", userStorage.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
