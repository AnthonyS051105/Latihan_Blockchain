// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is ERC20 {
    address public usdc; // alamat dari USDC

    constructor(address _usdc) ERC20("Vault", "VAULT") {
        usdc = _usdc; // set the USDC address
    }

    function deposit(uint256 amount) public {
        // shares = depositAmount / totalAsser * totalShares
        uint256 totalAssets = IERC20(usdc).balanceOf(address(this)); // total aset yang ada di vault. Di vault ini ada berapa usdc
        uint256 totalShares = totalSupply(); // total shares yang ada di vault

        uint256 shares = 0;         // jumlah shares yang akan didapatkan oleh depositor
        if (totalShares == 0) {
            shares = amount;
        } else {
            shares = amount * totalShares / totalAssets; // rumus untuk menghitung jumlah shares yang didapatkan
        }
        
        _mint(msg.sender, shares); // mint shares to the depositor (msg.sender)
        // transfer usdc 
        IERC20(usdc).transferFrom(msg.sender, address(this), amount); // transfer USDC from depositor to vault
    }

    function withdraw(uint256 shares) public {
        // amount = shares * totalAssets / TotalShares
        uint256 totalAsset = IERC20(usdc).balanceOf(address(this));
        uint256 totalShares = totalSupply();

        uint256 amount = shares * totalAsset / totalShares;

        _burn(msg.sender, shares); // burn shares from the withdrawer (msg.sender)
        
        // transfer USDC from vault to msg.sender
        IERC20(usdc).transfer(msg.sender, amount); // transfer USDC from vault to withdrawer (msg.sender)
    }

    function distributeYield(uint256 amount) public {
        IERC20(usdc).transferFrom(msg.sender, address(this), amount); // transfer USDC from msg.sender to vault
    }
}
