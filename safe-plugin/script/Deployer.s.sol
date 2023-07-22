// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Script.sol";
import {Deployer} from "../script/Deployer.s.sol";
import {ZkRecover} from "../src/ZkRecover.sol";
import {ISafeProtocolManager} from "@safe-global/safe-core-protocol/contracts/interfaces/Manager.sol";
import {ISafe} from "@safe-global/safe-core-protocol/contracts/interfaces/Accounts.sol";

// forge script script/Deployer.s.sol:Deployer --rpc-url $GOERLI_URL --broadcast --verify -vvvv


contract Deployer is Script {

    ISafe deploymentSafe = ISafe(0x503e83f02d35497A57CD07AD094614be6De8ab2b); 
    ISafeProtocolManager deploymentManager = ISafeProtocolManager(0x4026BA244d773F17FFA2d3173dAFe3fdF94216b9);

     function run() external returns (ZkRecover) {
        vm.startBroadcast(vm.envUint("DEPLOYMENT_KEY"));
        ZkRecover zkRecover = new ZkRecover();
        //(bool success,) = address(deploymentSafe).delegatecall(abi.encodeWithSignature("enableModule(address)", address(zkRecover)));
        vm.stopBroadcast(); 
        return zkRecover;
     } 
}
