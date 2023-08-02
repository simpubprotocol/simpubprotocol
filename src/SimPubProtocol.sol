// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "openzeppelin/token/ERC20/ERC20.sol";

/**
 * @title Simple Publishing Protocol
 * @author Daniel Wang <dan@taiko.xyz>
 * @dev This contract enables the publication of any form of data to the
 * Ethereum blockchain. The data may range in nature and complexity, hence
 * its utility may be highly situational.
 */
contract SimPubProtocol {
    /**
     * @dev This event gets emitted whenever a user publishes data on the
     * blockchain.
     * @param user The address of the user who is publishing the data.
     * @param spec A unique identifier (ID) that represents the type or nature
     * of the
     * data being published.
     * @param uriType The type of the Uniform Resource Identifier (URI)
     * that signifies where the data can be retrieved.
     * @param uri The URI that leads to the published data.
     * @param burnTo The address where the Ether or tokens are
     * burned to increase visibility.
     * @param burnToken The address of the token (if any) being burned. If 0,
     * Ether is being burned.
     * @param burnAmount The amount of Ether or tokens being burned to
     * enhance visibility.
     */
    event Publication(
        address indexed user,
        bytes32 indexed spec,
        bytes32 indexed uriType,
        string uri,
        address burnTo,
        address burnToken,
        uint256 burnAmount
    );

    error InvalidMsgValue();
    error TransferEtherFailed();

    /**
     * @notice This function allows a user to publish data onto the blockchain,
     * optionally
     * burning Ether or specific ERC20 tokens to increase attention.
     * @dev This publish function handles the burning of either Ether or ERC20
     * tokens to boost visibility.
     * @param spec An ID that defines the nature of the data being published.
     * @param uriType The type of URI which signifies where the published data
     * can be accessed.
     * @param uri The URI that points to the published data.
     * @param burnTo The address where Ether or ERC20 tokens are burned
     * for the sake of increasing visibility.
     * @param burnToken The address of the ERC20 token to be burned. If 0, Ether
     * is assumed.
     * @param burnAmount The quantity of Ether or ERC20 tokens to be burned.
     */
    function publish(
        bytes32 spec,
        bytes32 uriType,
        string calldata uri,
        address burnTo,
        address burnToken,
        uint256 burnAmount
    )
        external
        payable
    {
        if (burnToken == address(0)) {
            // Burn Ether
            if (msg.value != burnAmount) revert InvalidMsgValue();
            (bool sent,) = payable(burnTo).call{value: msg.value}("");
            if (!sent) revert TransferEtherFailed();
        } else {
            // Burn ERC20
            if (msg.value != 0) revert InvalidMsgValue();
            ERC20(burnToken).transferFrom(msg.sender, burnTo, burnAmount);
        }

        emit Publication(
            msg.sender, spec, uriType, uri, burnTo, burnToken, burnAmount
        );
    }
}
