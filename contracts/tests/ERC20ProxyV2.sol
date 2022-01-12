// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "../ERC20Proxy.sol";

contract ERC20ProxyV2 is ERC20Proxy {
  uint256 private _cap;

  /**
    * @dev Sets the value of the `cap`. This value is immutable, it can only be
    * set once during construction.
    */
  function setCap(uint256 cap_) external onlyOwner {
    require(_cap == 0 && cap_ >= this.totalSupply(), "cap is already setted");
    _cap = cap_;
  }

  /**
    * @dev Returns the cap on the token's total supply.
    */
  function cap() public view virtual returns (uint256) {
      return _cap;
  }

  function mint(address to, uint256 amount) external onlyOwner {
    require(this.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
    _mint(to, amount);
  }
}