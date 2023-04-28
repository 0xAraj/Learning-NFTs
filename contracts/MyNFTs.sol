// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract myCollection is ERC721, Ownable {
    uint public mintPrice = 0.05 ether;
    uint public totalSupply;
    uint public maxSupply = 5;
    uint internal tokenId = 1;
    bool public isMintEnabled;
    mapping(address => uint) public mintedWallet;

    constructor() ERC721("Aditya", "ADR") {}

    function toggleMint() public onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function changeMaxSupply(uint _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    function mintNFT() public payable {
        require(isMintEnabled, "Mint not enabled!");
        require(msg.value == mintPrice, "Not enough funds");
        require(mintedWallet[msg.sender] < 2, "Limit exceded");
        require(totalSupply < maxSupply, "Sold out!");
        tokenId++;
        mintedWallet[msg.sender]++;
        totalSupply++;
        _safeMint(msg.sender, tokenId);
    }
}
