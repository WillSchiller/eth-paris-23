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
 constructor() BasePluginWithEventMetadata(
            PluginMetadata({
                name: "Zk Recover Plugin",
                version: "1.0.0",
                requiresRootAccess: false, // may need to change
                iconUrl: "",
                appUrl: "https://github.com/WillSchiller/eth-paris-23"
            })
        ){};

        






}
