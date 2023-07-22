// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {BasePluginWithEventMetadata, PluginMetadata} from "./Base.sol";
import {ISafe} from "@safe-global/safe-core-protocol/contracts/interfaces/Accounts.sol";
import {ISafeProtocolManager} from "@safe-global/safe-core-protocol/contracts/interfaces/Manager.sol";
import {SafeTransaction, SafeProtocolAction} from "@safe-global/safe-core-protocol/contracts/DataTypes.sol";
import {UltraVerifier} from "@noir-zk/contract/plonk_vk.sol";

contract ZkRecover is BasePluginWithEventMetadata {

    error ChangeOwnerFailure(bytes reason);
    error VeriferMustBeUniqueAddress(address verifier);
    error VerifierNotUseable(Verifier verifier);

    /**
     * @dev each owner has a proof verifier contract. To prevent reply attacks verifiers are only useable once. 
     * Afer which the user must generate a new proof and reset the plugin.
     * 
     */

    mapping(address owner => Verifier) private verifiers;

    struct Verifier {
        address addr;
        bool useable;
    }


    constructor()
        BasePluginWithEventMetadata(
            PluginMetadata({
                name: "Zk Recover Plugin Just A Test",
                version: "1.0.0",
                requiresRootAccess: true,
                iconUrl: "",
                appUrl: "https://github.com/WillSchiller/eth-paris-23"
            })
        ){}

    function setproofVerifier(address verifier) external {
        if (verifiers[msg.sender].addr == verifier) revert VeriferMustBeUniqueAddress(verifier);
        verifiers[msg.sender].useable = true;
    }
    
    function verifyProof(bytes calldata _proof, bytes32[] calldata _publicInputs) internal returns (bool) {
       Verifier memory verifier = verifiers[msg.sender];
        if (verifier.useable == false) revert VerifierNotUseable(verifier);
        bool proofResult = UltraVerifier(verifier.addr).verify(_proof, _publicInputs);
        if (proofResult == true) {
            verifiers[msg.sender] = Verifier({addr: verifier.addr, useable: false});
            return true;
        } else {
            return false;
        }
    }

    function addOwnerWithThreshold(ISafeProtocolManager manager, ISafe safe, uint256 nonce, address newOwner, uint256 threshold)
        internal
    {
        //https://github.com/safe-global/safe-contracts/blob/main/contracts/base/OwnerManager.sol
        SafeProtocolAction[] memory actions = new SafeProtocolAction[](1);
        actions[0].to = payable(address(safe));
        actions[0].value = 0;
        actions[0].data = abi.encodeWithSignature("addOwnerWithThreshold(address owner, uint256 _threshold)", newOwner, threshold);

        SafeTransaction memory safeTx = SafeTransaction({actions: actions, nonce: nonce, metadataHash: bytes32(0)});
        try manager.executeTransaction(safe, safeTx) returns (bytes[] memory) {} catch (bytes memory reason) {
           revert ChangeOwnerFailure(reason); 
        } 
    }

    function executeFromPlugin(ISafeProtocolManager manager, ISafe safe, bytes calldata data, address newOwner, uint256 threshold) external {
        //if (trustedOrigin != address(0) && msg.sender != trustedOrigin) revert UntrustedOrigin(msg.sender);

        // We use the hash of the tx to relay has a nonce as this is unique
        uint256 nonce = uint256(keccak256(abi.encode(this, manager, safe, data)));
        addOwnerWithThreshold(manager, safe, nonce, newOwner, threshold);
    }



}

