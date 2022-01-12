// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "./ERC20Proxy.sol";

contract ERC20ProxyFactory {
  address immutable private tokenImplementation;
  address[] public tokens;

  event TokenDeployed(address tokenAddress);

  constructor() {
    tokenImplementation = address(new ERC20Proxy());
  }

  function createToken(string calldata name, string calldata symbol, uint256 initialSupply, address owner) external returns (address token) {
    ERC1967Proxy proxy = new ERC1967Proxy(
      tokenImplementation,
      abi.encodeWithSelector(ERC20Proxy.initialize.selector, name, symbol, initialSupply, owner)
    );
    token = address(proxy);
    tokens.push(token);
    emit TokenDeployed(token);
  }

  function createToken(bytes calldata data) external returns (address token) {
    ERC1967Proxy proxy = new ERC1967Proxy(
      tokenImplementation,
      data
    );
    token = address(proxy);
    tokens.push(token);
    emit TokenDeployed(token);
  }
}