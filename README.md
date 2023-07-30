# Simple Publishing Protocol

A dead simple protocol that allows the publication of any data to the blockchain. It allows various clients to access and interact with the published data, and apply their own client-side protocols. This protocol may be completely useless or very useful.

### Code

```solidity
/**
 * @title Simple Publishing Protocol
 * @author Daniel Wang <dan@taiko.xyz>
 * @dev A dead simple contract that allows the publication of any data to the
 * blockchain. It may be completely useless or very useful.
 */
contract SimPubProtocol {
    /**
     * @dev Emitted when a user publishes data.
     * @param user The address of the user who published the data.
     * @param spec An ID representing the nature of the published data.
     * @param uriType The type of the URI indicating where to retrieve the data.
     * @param uri The URI that points to the published data.
     * @param burn The amount of Ether burned (if any) to increase visibility.
     */
    event Publication(
        address indexed user,
        bytes32 indexed spec,
        bytes32 indexed uriType,
        string uri,
        uint256 burn
    );

    /**
     * @notice Publish any data, optionally burning Ether to increase attention.
     * @dev The publish function allows a user to broadcast data to the
     * blockchain.
     * @param spec An ID indicating the nature of the published data.
     * @param uriType The type of the URI specifying where the data can be
     * accessed.
     * @param uri The URI of the published data.
     */
    function publish(
        bytes32 spec,
        bytes32 uriType,
        string calldata uri
    )
        external
        payable
    {
        // Do nothing, but
        emit Publication(msg.sender, spec, uriType, uri, msg.value);
    }
}
```

### Deployments

- Sepolia Testnet: https://sepolia.etherscan.io/address/0x936b23e25e9a52758cda02bdedffa8c921a1b832
- Ethereum Mainnet: https://etherscan.io/address/0xeb263a72abc4bdd6d228895c82158801506e9a23
