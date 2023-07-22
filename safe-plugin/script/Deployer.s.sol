// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Script.sol";
import {Deployer} from "../script/Deployer.s.sol";
import {ZkRecover} from "../src/ZkRecover.sol";


contract Deployer is Script {

     function run() external returns (ZkRecover) {
        vm.startBroadcast(vm.envUint("DEPLOYMENT_KEY"));
        ZkRecover zkRecover = new ZkRecover();
        vm.stopBroadcast();
        return zkRecover;
     } 
}
