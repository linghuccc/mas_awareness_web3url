// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
    uint256 private _currentTokenId;
    string private _uri;

    event NftMinted(address indexed recipient, uint256 indexed tokenId);
    event UriUpdated(string URI);

    constructor(
        string memory name,
        string memory symbol,
        string memory strURI
    ) ERC721(name, symbol) Ownable(_msgSender()) {
        _uri = strURI;
    }

    function mint() external returns (uint256) {
        // NFT tokenId will start from 1
        uint256 newItemId = ++_currentTokenId;
        address recipient = _msgSender();
        _safeMint(recipient, newItemId);

        emit NftMinted(recipient, newItemId);

        return newItemId;
    }

    function updateUri(string memory newURI) external onlyOwner {
        _uri = newURI;

        emit UriUpdated(newURI);
    }

    function _baseURI() internal view override returns (string memory) {
        return _uri;
    }
}
