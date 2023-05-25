// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract SimpleMintContract is ERC721, Ownable {
    uint256 public mintPrice = 0.05 ether; // mint price that will be costing to the consumers
    uint256 public totalSupply; //how many NFT's are there in space
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;
    constructor() payable ERC721('SimpleMint', 'SIMPLEMINT'){
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner{
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner{
        maxSupply = maxSupply_;
    }

    function mint() external payable {
        require(isMintEnabled, 'minting is not enabled'); // function will stop if isMintEnabled is not true
        require(mintedWallets[msg.sender]<1, 'exceeds max per wallet'); //msg.sender will give address of person running the function
        require(msg.value == mintPrice, 'wrong value'); // msg.value puts the price for mint;
        require(maxSupply>totalSupply, 'sold out');


        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId); // comes from ERC 721
    }
}
