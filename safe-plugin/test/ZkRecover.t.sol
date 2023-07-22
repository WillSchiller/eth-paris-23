// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISafeProtocolManager} from "@safe-global/safe-core-protocol/contracts/interfaces/Manager.sol";
import {ISafe} from "@safe-global/safe-core-protocol/contracts/interfaces/Accounts.sol";
import {Test} from "forge-std/Test.sol";
import {ZkRecover} from "../src/ZkRecover.sol";
import {Deployer} from "../script/Deployer.s.sol";




contract ZkRecoverTest is Test {
    ZkRecover public zkRecoverPlugin;
    ISafe safe = ISafe(0x1ec5dEba915c853298c1e990eC785eb625116d8d); 
    ISafeProtocolManager manager = ISafeProtocolManager(0x4026BA244d773F17FFA2d3173dAFe3fdF94216b9);
    bytes data;
    address newOwner = address(0x00001);
    uint256 threshold = 1;
    address registry = 0x9EFbBcAD12034BC310581B9837D545A951761F5A;
    address owner;



// add network fork to test

    function setUp() public {
        Deployer deployer = new Deployer();
        zkRecoverPlugin = deployer.run();
        //address(safe).call(abi.encodeWithSignature("enablePlugin(address)", address(manager)));
        data = abi.encode(
        address(zkRecoverPlugin),
        address(manager),
        address(safe),
        hex"6a761202"
    );
    }

    function testZkRecover() public {
        zkRecoverPlugin.executeFromPlugin(manager, safe, data, newOwner, threshold);
    }
}
