// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Script.sol";
import {Deployer} from "../script/Deployer.s.sol";
import {ZkRecover} from "../src/ZkRecover.sol";


contract Deployer is Script {
    ZkRecover public zkRecover;

     function run() external returns (ZkRecover) {
        vm.startBroadcast(vm.envUint("DEPLOYMENT_KEY"));
        Deployer deployer = new Deployer();
        zkRecover = deployer.fun();
        vm.stopBroadcast();
        return zkRecover;
     } 
}
