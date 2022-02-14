// contracts/CryptoBeetles.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoBeetles is ERC721URIStorage , Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; 

    bool private revealed = false;
    string public notRevaleUri;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory initBaseURI,
        string memory _initNotRevealedURI,
      ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
        setNotRevealedURI(_notRevealedUri);
      }

    function mint(string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    function tokenURI(uint256 tokenId)
       public 
       view
       virtual 
       override
       return (string memory)
    {
        require(
            _exists(tokenId)
            "ERC721Metadata URI query for noneexistent token "
        );
        if(revealed == false) {
            return _notRevealedUri;
        }

        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, tokenId.tostring(), baseExtension))
            :"";
    } 


    function reveal() public onlyOner() {
        revealed = true;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI
    }
    function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
        notRevaleUri = _notRevealedURI;
    }

}