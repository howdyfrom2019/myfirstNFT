// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// ERC165, 어떤 Contract에서 어떤 인터페이스의 내용을 구현 하였는지를 확인 하기 위한 기능을 명시 한 인터페이스!
interface ERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    ///  uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}


/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// Note: the ERC-165 identifier for this interface is 0x80ac58cd.
interface ERC721 is ERC165 {
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /// @dev This emits when an operator is enabled or disabled for an owner.
    ///  The operator can manage all NFTs of the owner.
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    // owner 주소의 보유한 NFT 총 개수를 반환 한다.
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address owner) external view returns (uint256);

    // 특정 NFT의 ID를 소유한 owner의 address를 찾아서 반환 한다.
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 tokenId) external view returns (address);

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) external payable;

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev This works identically to the other function with an extra data parameter,
    ///  except this function just sets data to "".
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable;

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param from The current owner of the NFT
    /// @param to The new owner
    /// @param tokenId The NFT to transfer
    function transferFrom(address from, address to, uint256 tokenId) external payable;

    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param approved The new approved NFT controller
    /// @param tokenId The NFT to approve
    function approve(address approved, uint256 tokenId) external payable;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param operator Address to add to the set of authorized operators
    /// @param approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address operator, bool approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param owner The address that owns the NFTs
    /// @param operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

interface ERC721Metadata
{
    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol);

    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    function tokenURI(uint256 _tokenId) external view returns (string memory);
}

contract IcyJustices is ERC721Metadata, ERC721 {
    string _name = "icy";
    string _symbol = "ij";
    mapping(uint256 => string) _tokenURIS;
    mapping(address => uint256) _balanceByOwner;
    mapping(uint256 => address) _ownerByTokenId;
    mapping(uint256 => address) _operatorByTokenId;
    mapping(address => mapping(address => bool)) _operatorsByOwner;
    uint256 _totalTokenCount = 0;
    address _owner;

    constructor() {
        _owner = msg.sender;
    }

    function name() external override view returns(string memory) {
        return _name;
    }

    function symbol() external override view returns(string memory) {
        return _symbol;
    }

    function tokenURI(uint256 _tokenId) external override view returns(string memory) {
        // todo, tokenId에 해당하는 토큰이 민팅 되었는지? require(_tokenId)
        return _tokenURIS[_tokenId];
    }

    function mint(address to, uint256 tokenId, string memory uri) public {
        //to가 유효한 address인가?
        //tokenId가 이미 발행되어있는가? 이미 소유주가 있는가?

        require(to == address(0), "address is not valid");
        require(_ownerByTokenId[tokenId] != address(0), "this is not issued");
        //owner check;
        _ownerByTokenId[tokenId] = to;
        _balanceByOwner[to]++;
        _tokenURIS[tokenId] = uri;
        _totalTokenCount++;

    }

    function balanceOf(address owner) external override view returns (uint256) {
        return _balanceByOwner[owner];
    }


    function ownerOf(uint256 tokenId) external override view returns (address) {
        return _operatorByTokenId[tokenId];
    }


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public override payable {
        //todo, 예외처리가 필요함.
        //from == to 이면 ㄴ안됨.
        // tokenId가 진짜 발행이 됐나? 소유한 사람이 있는가?
        //token의 주인과 from이 같은가?
        // from이 token을 소유했는가?
        //from이 소유주가 아니라면, 이 토큰에 대해서 권한 위임을 받았는가?
        // token이 소유주로부터 모든 전권을 ㄹ받았는가?
        //to가 유효한 address인가?

        require(from != to, "can't send to same account");
        require(_ownerByTokenId[tokenId] == address(0), "this token isn't issued");
        require(from == _ownerByTokenId[tokenId], "invalid from");
        require(_ownerByTokenId[tokenId] == msg.sender || getApproved(tokenId) == msg.sender, "you aren't token owner");
        require(!isApprovedForAll(_ownerByTokenId[tokenId], from), "this token isn't got all auths");
        require(to == address(0), "this address is not valid");
        // external은 내부 함수를 호출할 수 없기 때문에 public으로 전환해준다.
        _balanceByOwner[from]--;
        _balanceByOwner[to]++;
        _ownerByTokenId[tokenId] = to;
        //수수료 처리

        // from이 owner가 아닐 때, token하나에 대해서 위임을 받은 경우 위임을 지워야함.
        delete _operatorByTokenId[tokenId];

        emit Transfer(_ownerByTokenId[tokenId], to, tokenId);
    }


    function safeTransferFrom(address from, address to, uint256 tokenId) external override payable {
        safeTransferFrom(from, to, tokenId, "");
    }


    function transferFrom(address from, address to, uint256 tokenId) external override payable {
        safeTransferFrom(from, to, tokenId, "");
    }


    function approve(address approved, uint256 tokenId) external override payable {
        require(_operatorByTokenId[tokenId] == address(0), "already approved");
        _operatorByTokenId[tokenId] = approved;

        emit Approval(msg.sender, approved, tokenId);
    }


    function setApprovalForAll(address operator, bool approved) external override {
        address owner = msg.sender;
        _operatorsByOwner[owner][operator] = approved;

        emit ApprovalForAll(owner, operator, approved);
    }


    function getApproved(uint256 tokenId) public override view returns (address) {
        return _operatorByTokenId[tokenId];
    }


    function isApprovedForAll(address owner, address operator) public override view returns (bool) {
        return _operatorsByOwner[owner][operator];
    }

    function supportsInterface(bytes4 interfaceID) external override view returns (bool) {
        return (
        type(ERC721).interfaceId == interfaceID ||
        type(ERC721Metadata).interfaceId == interfaceID
        );
    }
}