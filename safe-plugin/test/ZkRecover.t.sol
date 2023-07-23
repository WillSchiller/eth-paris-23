// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISafeProtocolManager} from "@safe-global/safe-core-protocol/contracts/interfaces/Manager.sol";
import {ISafe} from "@safe-global/safe-core-protocol/contracts/interfaces/Accounts.sol";
import {Test} from "forge-std/Test.sol";
import {ZkRecover} from "../src/ZkRecover.sol";
import {Deployer} from "../script/Deployer.s.sol";
import {UltraVerifier} from "@noir-zk/contract/plonk_vk.sol";


// forge test  --fork-url $GOERLI_URL -vvvv


contract ZkRecoverTest is Test {
    ZkRecover public zkRecoverPlugin;
    UltraVerifier public verifier;

    ISafe safe = ISafe(0x503e83f02d35497A57CD07AD094614be6De8ab2b); 
    ISafeProtocolManager manager = ISafeProtocolManager(0x4026BA244d773F17FFA2d3173dAFe3fdF94216b9);
    uint256 nonce = 10;
    address newOwner = address(0x00001);
    uint256 threshold = 1;
    address registry = 0x9EFbBcAD12034BC310581B9837D545A951761F5A;
    address owner;

    



// add network fork to test

    function setUp() public {
        //Deployer deployer = new Deployer();
        //zkRecoverPlugin = deployer.run();
        verifier = new UltraVerifier();

        vm.prank(0x503e83f02d35497A57CD07AD094614be6De8ab2b);
        zkRecoverPlugin = ZkRecover(0x73a05aA963bbEd411861d11A9DCE7f0011877195);
    }

    function testZkRecover() public {
        //zkRecoverPlugin.executeFromPlugin(manager, safe, nonce, newOwner, threshold);
    }

    function testVerifyProof() public {
        //bytes memory proof = bytes("2a4b39b3eb6be3f5dd19e6cf2f56e07a62fe03f7ef69f5047cecdadd82032d731e749ee68829ef22d8eeba3923bc82911a829b1ef49e062f177a10bb28dd7c602414624dedab2dc32f9896e1972850556cb744479c06465b68e14d10abb3867317e591a2ddc5bc25a32ec458dd8b3417c10f76302421506d526d88ffe2cbf704082588fc0b308d16893da43c44de8f57e8b09972dbcc5aebd5575c85ff5270d01dd360e16cd5cd6f62d4075b62bc98a613994e93917a024f8a11ebe475a554ee162705a83275de5dd09f177228065ab8b9347d97c760be49c86bcf421fb5583f0637cf50c718cbf9e1bec1c008053509cc134f85b583118060f7fb7a6083675b2f550b85387741c372b6bd1f62e15522555a7d5a6c3e0c28aa8717a8af8d2bd11373433724b6d42ece4e5c72991dbe049a842fa0349b9645bf82bc18d316163b0a3c29993a8d4191efb7c27ab94df15939157d2eef2d3db6b7fc738c5a78be1810bfe044b416ef678553256ac97a4e8947f9d62b74feadcf30fc1edea0036a660af17bcf26f2c1a69feef2d7ea4b5acd505369746e44a572adb8e4c2e6d4fd041a442533417d223eebcc96848588c444a5be7061a1695da0e7f5ce76358e798a00bbd2013f4259b77fa390fcc876d941743547c33c12a6b840f29c6a7e7cea000134b18b7eca456f563742233534bb0e39f54cac94d067e84af274c0e728b6401e3a229399c0285a381fe79d08b35d27e2608028b4e1640ad2a05febde810663252ddac6668363691e385bc952938145fcea07a47b0218d02827895f72653a091573d09c01f8477149ecb40f2b7ff891040ae71df0a42dfc31173cf7b55c61fd300bda8d149bff23c9c436038fa60ce7969cb360cab8cdbc8abecd45a67c672725f2f3dba14df431d1bfc2c5d2900037ff7bc9f35e7c85097a3cf2c7ee74de1f0f3d21dadc7f9bfd6162ff29d56ed9697396ae83904103afe36d8fce1513d6172a2dd55e296d387eec255160947b136d16bc8c0f0dadb87e984a91a646acb84701f2b2318a160b2f890ab5a7dc10bd229f620a1384dd086c65c053155bb1fbfa1adfadf4dcddd16f1ea8072476f186882b8fd53473301c4db1d55f6b629a155008c7e37d1e0d271729533b2ffd9fb2b9888680a4549921b8a4aa6c07ca7030b5071ef55bc83fa711d66253994b7657cc84733f44ac4696fb6ff987b5998f2091106d0cd189afa081d78623d69d1738504f6535b3fe0014e0b2845220693e2f0b23bc22e1f2ac51b2cb1fe3cbf4b656eb416e4b8e386069a10ea7897d9062feec23c02c2465548161cd15f9e94e08166f44715df5de4d66c63219ef54495b58330f5f1846598a2c6ef9740613a56e2850f4502c2f8aacd9796dd1bef2dc2facb925a29fbe6cb75e44dcc682654c654bb930234ee3dbb6cddc2272e6feff610a4a0434aa506485d0cb3cfb07ad45a7e50653eb5f59b10da1578c631d658631aa210e8f83dc278c9e364a9480d774b4625a0b7fcf01bd9bab0cc7b9de4feecb064d1e0beb9bc4b75bb715cc399bf0b98990fa3859e6b3e6807eedf929cf9be4773a17b7e8708f0de04545d44709db5a1a265a4b5f0761901d2ea2c9b162767b8e9803c4a6699d12ac3744ceeb6983527be95a2c47ea93d200ea630616463dc60c8f101707b8f3c13acfb4b1433bb70bbcfd291f82d2d9dca1d8c00c8f5324b403ef17412dbdd286e15d3294fd1dbd544d956b0c55d5e326321d6b270fde98c8045f0d5ea839fa25c819f4d27a7d1aef9b8ff5f84b76ecd1c688d8f3a9c86bc467241cd5e46eccc27eac3e4d30a299fd366a2d60ed8595d4832f9c4015b1f5b9c95505653c803718e169ecdf47c96bc1092757884f2fccde2d965cc0058f21abb46313e65e89e607b2e9b34a1c046449e5d74f465c9fe916a151536f3efdb481780b2b9a0f2010e4d0142a198af291314ee8751a9d5e8f42a907ac4d8d84e87820dd02dd0a76471acbeb9df75af953c5d6a14ade9ed3938ef3747f69ddc3061525c515fe5b1a36fcb0d005dacb1e1c7e8e98ab04119527fe31614ba000d990ba48620d744085c04705fe5b53a8b435737751bb0ac1f39c9428ab21d7e1094e33d17a1638b287a4e02a8e7496430b4d04ba59fd974dfb345b37e3ee39635dd9a4dc93289120464e7e0bb0b6fd3075344dacb0a991deffdc85b8ed8509b5bbbfc0e4f42272c8112d5694e83697d3737ed24686da399fa57ffeb3fe95534c755fba5ed01ee620bf0708ea7e85ad871b403d7a863168e396940b0e23152174b1995c1fc60220778585d5e795d99c7074215b99b7fae5f394157c189bc724ee2abafed0fa0867430c24422e2e5b9536d02bb041bf899509c4ce27b1643ce95100875722ff060ccb3d7bf14305f0779089fc636779140090344288ce1e85307faf814c27180668ae1cd4031eae965f740193522d5b58829e50a6062127bb63868fb25481ee2d3922ccacd3aa44b3b5a1105cd76fd796c8ed7560b51eedea4be25fe0cb33d01fcab4e3b748ede649926edee9209e644abb5a6020234e5bfe5602d8fb041b1f05eb0da5ceb2e1b84bd8769f4f9989c0e5e91e5067a14889de36cf5e7aad24190e77c62f464878bdca2a8a136d0359d8f036f8c36966746b1d3e4db04646f1b02fc4098c5265c7473adac324c1fd74602060b418881160467b4efcb1427dd6e118352a934ef3fa18a54d0486c43294de7e9df8c0ee1c1662de19060f7d3ed02b12b10753a8bfeac9c8ec024464283ac1852680ce9da857762bfb9e09b1f688dd26d653892900bad20ddf43b7b41ce7020ac749b6908dc399dfe30b62bd4a705d2645819cba307e7c88ee8a1985d4267bef3adc5c02ebab41b2c825f161fe9f4c2f47a60af2d4dc3ed37d03a6bff9eb6700f53ada88916f4517949702c588b3c21f56a722e17748cd861a56750303668e10503083e186030d0c1896bf214afaf2190073a179fd4db63ce45462d0cc353ff0531a89f2844d4634ae0eb6896af612");
        //bytes32[32] memory temp = [bytes32("190"), "31", "112", "6", "58", "1", "0", "85", "208", "15", "131", "187", "154", "236", "131", "18", "25", "1", "225", "166", "150", "70", "118", "122", "227", "71", "156", "35", "11", "3", "12", "231"];
        //bytes32[] memory _publicInputs = new bytes32[](32);
        //for (uint i = 0; i < 32; i++) {
        //    _publicInputs[i] = temp[i];
        //}
        //zkRecoverPlugin.setProofVerifier(address(verifier));
        //bool result = zkRecoverPlugin.verifyProof(proof, _publicInputs);
        //assertEq(result, true);
    }

  
       
      
}
