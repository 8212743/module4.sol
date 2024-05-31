// SPDX-License-Identifier: MIT
/*
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.0/contracts/access/Ownable.sol";


contract tineshop is ERC20, Ownable {
    mapping(uint256 => uint256) public itemPrices;

    constructor() ERC20("Degen", "DGN") {
        itemPrices[1] = 150;
        itemPrices[2] = 130;
        itemPrices[3] = 100;
        itemPrices[4] = 80;
    }

    function mintTokens(address recipient, uint256 amount) public onlyOwner {
        _mint(recipient, amount);
    }

    function transferTokens(address recipient, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Transfer Failed: Insufficient balance.");
        _transfer(msg.sender, recipient, amount);
    }

    function displayShopItems() external pure returns (string memory) {
        return "The Shirt on sale: {1} Long Sleeve (150) {2} Black Shirt (130) {3} White Shirt (100) {4} Polo (80)";
    }

    function redeemItem(uint256 itemId) public {
        uint256 price = itemPrices[itemId];
        require(price > 0, "Item is not available.");
        require(balanceOf(msg.sender) >= price, "Redeem Failed: Insufficient balance.");
        _transfer(msg.sender, owner(), price);
    }

    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function checkBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
}
