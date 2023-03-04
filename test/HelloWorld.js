const { expect } = require("chai");

describe("HelloWorld contract", function () {
  it("Deployment should assign the greet variable to 'Hello World!'", async function () {
    const [owner] = await ethers.getSigners();

    const HelloWorld = await ethers.getContractFactory("HelloWorld");

    const hello_world = await HelloWorld.deploy();

    await hello_world.deployed();

    expect(await hello_world.greet()).to.equal("Hello World!");
  });
});
