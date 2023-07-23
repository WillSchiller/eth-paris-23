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
        bool void;
    }


    constructor()
        BasePluginWithEventMetadata(
            PluginMetadata({
                name: "Zk Recover Plugin",
                version: "1.0.0",
                requiresRootAccess: true,
                iconUrl: "",
                appUrl: "https://github.com/WillSchiller/eth-paris-23"
            })
        ){}

    function setProofVerifier(address verifier) external {
        if (verifiers[msg.sender].addr == verifier) revert VeriferMustBeUniqueAddress(verifier);
        verifiers[msg.sender] = Verifier({addr: verifier, void: true});
    }
    
    function verifyProof(bytes memory _proof, bytes32[] memory _publicInputs) public returns (bool) {
       Verifier memory verifier = verifiers[msg.sender];
        if (verifier.void == true) revert VerifierNotUseable(verifier);
        bool proofResult = UltraVerifier(verifier.addr).verify(_proof, _publicInputs);
        if (proofResult == true) {
            verifiers[msg.sender] = Verifier({addr: verifier.addr, void: true});
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

        SafeTransaction memory safeTx = SafeTransaction({actions: actions, nonce: 6, metadataHash: bytes32(0)});
        try manager.executeTransaction(safe, safeTx) returns (bytes[] memory) {} catch (bytes memory reason) {
           revert ChangeOwnerFailure(reason); 
        } 
    }

    function executeFromPlugin(ISafeProtocolManager manager, ISafe safe, uint256 nonce, address newOwner, uint256 threshold) external {

        addOwnerWithThreshold(manager, safe, nonce, newOwner, threshold);
    }



}

