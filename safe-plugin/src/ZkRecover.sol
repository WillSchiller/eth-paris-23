// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {BasePluginWithEventMetadata, PluginMetadata} from "./Base.sol";
import {ISafe} from "@safe-global/safe-core-protocol/contracts/interfaces/Accounts.sol";
import {ISafeProtocolManager} from "@safe-global/safe-core-protocol/contracts/interfaces/Manager.sol";
import {SafeTransaction, SafeProtocolAction} from "@safe-global/safe-core-protocol/contracts/DataTypes.sol";



contract zkRecover is BasePluginWithEventMetadata {
    /**
     * TODO:
     * Events
     * errors
     */

    error ChangeOwnerFailure(bytes reason);


    constructor()
        BasePluginWithEventMetadata(
            PluginMetadata({
                name: "Zk Recover Plugin",
                version: "1.0.0",
                requiresRootAccess: false, // may need to change
                iconUrl: "",
                appUrl: "https://github.com/WillSchiller/eth-paris-23"
            })
        )
    {}

    function addOwnerWithThreshold(ISafeProtocolManager manager, ISafe safe, uint256 nonce, address newOwner, uint256 threshold)
        internal
    {
        //https://github.com/safe-global/safe-contracts/blob/main/contracts/base/OwnerManager.sol
        SafeProtocolAction[] memory actions = new SafeProtocolAction[](1);
        actions[0].to = payable(feeToken);
        actions[0].value = 0;
        actions[0].data = abi.encodeWithSignature("addOwnerWithThreshold(address owner, uint256 _threshold)", newOwner, threshold);

        SafeTransaction memory safeTx = SafeTransaction({actions: actions, nonce: nonce, metadataHash: bytes32(0)});
        try manager.executeTransaction(safe, safeTx) returns (bytes[] memory) {} catch (bytes memory reason) {
            revert ChangeOwnerFailure(reason);
        }
    }

      function executeFromPlugin(ISafeProtocolManager manager, ISafe safe, bytes calldata data, address newOwner, uint256 threshold) external {
        if (trustedOrigin != address(0) && msg.sender != trustedOrigin) revert UntrustedOrigin(msg.sender);

        // We use the hash of the tx to relay has a nonce as this is unique
        uint256 nonce = uint256(keccak256(abi.encode(this, manager, safe, data)));
        addOwnerWithThreshold(manager, safe, nonce, newOwner, threshold);
    }



}

