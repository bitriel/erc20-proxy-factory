// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract ERC20Proxy is
  ERC20PresetFixedSupplyUpgradeable,
  UUPSUpgradeable,
  OwnableUpgradeable
{
  function initialize(
    string memory name,
    string memory symbol,
    uint256 initialSupply,
    address owner
  ) public override initializer {
    __ERC20PresetFixedSupply_init(name, symbol, initialSupply, owner);
    __Ownable_init();
    transferOwnership(owner);
  }

  // solhint-disable no-empty-blocks
  function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}