<div align="center">
  <h1 align="center">ERC-4906: EIP-721 Metadata Update Extension</h1>
  <p align="center">
    <a href="https://discord.gg/qqkBpmRDFE">
        <img src="https://img.shields.io/badge/Discord-6666FF?style=for-the-badge&logo=discord&logoColor=white">
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=Carbonable_io">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white">
    </a>       
  </p>
  <h3 align="center">EIP-721 Metadata Update Extension Contracts written in Cairo for Starknet.</h3>
</div>

### About

A Cairo implementation of [EIP-4906](https://eips.ethereum.org/EIPS/eip-4906) based on [Openzeppelin Solidity implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/IERC4906.sol). EIP-4906 is an Ethereum standard for EIP-721 Metadata Update Extension.

> ## ⚠️ WARNING! ⚠️
>
> This is repo contains highly experimental code.
> Expect rapid iteration.
> **Use at your own risk.**

### Project setup

#### 📦 Requirements

- [protostar](https://github.com/software-mansion/protostar)

### 🎉 Install

```bash
protostar install
```

### ⛏️ Compile

```bash
make
```

### 🌡️ Test

```bash
# Run all tests
make test

# Run only unit tests
protostar test tests/units

# Run only integration tests
protostar test tests/integrations
```

## 📄 License

This project is released under the MIT license.
