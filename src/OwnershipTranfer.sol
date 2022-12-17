// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IGaugeProxy} from "./interfaces/IGaugeProxy.sol";
import {IGauge} from "./interfaces/IGauge.sol";
import {IGaugeController} from "./interfaces/IGaugeController.sol";
import {IGovernorBravo} from "./interfaces/IGovernorBravo.sol";
import {IPoolProxy} from "./interfaces/IPoolProxy.sol";
import {ITimeLock} from "./interfaces/ITimeLock.sol";

contract MobiusOwnershipTransfer {
    address constant TIMELOCK = 0x7d9Af9dF33D6CAB895B4cF3422D790cbE98B48c8;
    address constant POOL_PROXY = 0x1bc2DbB8c4d04AaCF4A7fefcDB060766964B5237;
    address constant GAUGE_PROXY = 0x0a3Ac12422C95F84b5bD18A6d9904d132a161C68;
    address constant GOVERNOR_BRAVO = 0xA5Eb84773633f33d442ECDaC48212B0dEBf3C84A;
    address constant GAUGE_CONTROLLER = 0x7530E03056D3a8eD0323e61091ea2f17a1aC5C25;
    address constant MOBI_MULTISIG = 0x16E319d8dAFeF25AAcec0dF0f1E349819D36993c;

    address constant EXPLOITER = 0x6BE0fF2BED16a50169f941DafEf6be050182f88c;

    address[24] pools = [0xC0BA93D4aaf90d39924402162EE4a213300d1d60, 0xEBf0536356256f8FF2a5Eb6C65800839801d8B95, 0x9F4AdBD0af281C69a582eB2E6fa2A594D4204CAe, 0x74ef28D635c6C5800DD3Cd62d4c4f8752DaACB09, 0x9906589Ea8fd27504974b7e8201DF5bBdE986b03, 0xF3f65dFe0c8c8f2986da0FEc159ABE6fd4E700B4, 0xaEFc4e8cF655a182E8346B24c8AbcE45616eE0d2, 0xcCe0d62Ce14FB3e4363Eb92Db37Ff3630836c252, 0xA5037661989789d0310aC2B796fa78F1B01F195D, 0x0986B42F5f9C42FeEef66fC23eba9ea1164C916D, 0xa2F0E57d4cEAcF025E81C76f28b9Ad6E9Fbe8735, 0xFc9e2C63370D8deb3521922a7B2b60f4Cff7e75a, 0x23C95678862a229fAC088bd9705622d78130bC3e, 0x02Db089fb09Fda92e05e92aFcd41D9AAfE9C7C7C, 0x63C1914bf00A9b395A2bF89aaDa55A5615A3656e, 0x2080AAa167e2225e1FC9923250bA60E19a180Fb2, 0x19260b9b573569dDB105780176547875fE9fedA3, 0xE0F2cc70E52f05eDb383313393d88Df2937DA55a, 0xdBF27fD2a702Cc02ac7aCF0aea376db780D53247, 0x0ff04189Ef135b6541E56f7C638489De92E9c778, 0x413FfCc28e6cDDE7e93625Ef4742810fE9738578, 0x382Ed834c6b7dBD10E4798B08889eaEd1455E820, 0x81B6a3d9f725AB5d706d9e552b128bC5bB0B58a1, 0xFa3df877F98ac5ecd87456a7AcCaa948462412f0];
    address[23] gauges = [0x7ed927E685d7196Ff2e7Bc48c5cB5e8af88c9332, 0x70AE7265545f001cb015399D672B85D8f2CaCA72, 0x107F94409746E8c8E6eFF139A100D17D9ca7FdfE, 0x487c30CB18AA9Ced435911E2B414e0e85D7E52bB, 0xc96AeeaFF32129da934149F6134Aa7bf291a754E, 0xE1f9D952EecC07cfEFa69df9fBB0cEF260957119, 0x127b524c74C2162Ee4BB2e42d8d2eB9050C0293E, 0x0A125D473cd3b1968e728DDF7d424c928C09222A, 0xdAA2ab880b7f3D5697e6F85e63c28b9120AA9E07, 0xF2ae5c2D2D2eD13dd324C0942163054fc4A3D4d9, 0xE7195E651Cc47853f0054d85c8ADFc79D532929f, 0xD0d57a6689188F854F996BEAE0Cb1949FDB5FF86, 0xCAEd243de23264Bdd8297c6eECcF320846eee18A, 0x2459BDb59a3BF6Ab6C412Ac0b220e7CDA1D4ea26, 0x27D9Bfa5F864862BeDC23cFab7e00b6b94488CC6, 0x52517feb1Fc6141d5CF6718111C7Cc0FD764fA5d, 0x1A8938a37093d34581B21bAd2AE7DC1c19150C05, 0xD38e76E17E66b562B61c149Ca0EE53CEa1145733, 0xe2d6095685248F38Ae9fef1b360D772b78Ea19D1, 0xd1B3C05FE24bda6F52e704daf1ACBa8c440d8573, 0x5489b2F0A1992b889F47601D71E068Fd15c63f26, 0xCF34F4ec5DC9E09428A4f4a45475f6277694166c, 0x1250D6dd3B51D20c14a8ECb10CC2dd713967767e];

    address[20] burners = [0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0xf14A820565010d95bD7ebda754e32811325394a4,0xf14A820565010d95bD7ebda754e32811325394a4,0x2f0e18532b18Ac3D67f055e652C87Ed78560A556,0x2f0e18532b18Ac3D67f055e652C87Ed78560A556,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0xbA270ceb17621CEb240A1A62dE43B37D148d2774,0xbA270ceb17621CEb240A1A62dE43B37D148d2774,0xe26b9d9C77ac382222D9473d029b6ffaE1aa13Ca,0xe26b9d9C77ac382222D9473d029b6ffaE1aa13Ca,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0x13bCDEB0947200Dd2F1933c2dC47a01157aA9414,0xbA270ceb17621CEb240A1A62dE43B37D148d2774,0xe26b9d9C77ac382222D9473d029b6ffaE1aa13Ca];
    address[20] tokens_to_burners = [0x765DE816845861e75A25fCA122bb6898B8B1282a,0xEd193C4E69F591E42398eF54DEa65aa1bb02835c,0xef4229c8c3250C675F21BCefa42f58EfbfF6002a,0x90Ca507a5D4458a4C6C6249d186b6dCb02a5BCCd,0x2DEf4285787d58a2f811AF24755A8150622f4361,0x122013fd7dF1C6F636a5bb8f03108E876548b455,0xD629eb00dEced2a080B7EC630eF6aC117e614f1b,0xBAAB46E28388d2779e6E31Fd00cF0e5Ad95E327B,0x1bfc26cE035c368503fAE319Cc2596716428ca44,0x2A3684e9Dc20B857375EA04235F2F7edBe818FA7,0xb70e0a782b058BFdb0d109a3599BEc1f19328E36,0xEadf4A7168A82D30Ba0619e64d5BCf5B30B45226,0x471EcE3750Da237f93B8E339c536989b8978a438,0x301a61D01A63c8D670c2B8a43f37d12eF181F997,0xD8763CBa276a3738E6DE85b4b3bF5FDed6D6cA73,0xD8761DD6c7cB54febD33adD699F5E4440b62E01B,0xB4aa2986622249B1F45eb93F28Cfca2b2606d809,0xCD7D7Ff64746C1909E44Db8e95331F9316478817,0xE74AbF23E1Fdf7ACbec2F3a30a772eF77f1601E1,0x56072D4832642dB29225dA12d6Fd1290E4744682];

    uint constant SWAP_FEE = 2 * 10 ** 7;
    uint constant DEPOSIT_FEE = 0;
    uint constant WITHDRAW_FEE = 0;
    uint constant ADMIN_FEE = 5 * 10 ** 9;

    mapping(address => uint) deposits;

    address bountyToken;

    uint cliff;

    constructor(address _bountyToken, uint daysToReturnControl) {
        bountyToken = _bountyToken;
        cliff = block.timestamp + 1 days * daysToReturnControl;
    }

    function deposit(uint amount) external {
        require(IERC20(bountyToken).transferFrom(msg.sender, address(this), amount), "Transfer failed");
        deposits[msg.sender] += amount;
    }

    function claim() external {
        require(cliff > block.timestamp, "Grace period has not been met");
        uint toClaim = deposits[msg.sender];
        deposits[msg.sender] -= toClaim;
        IERC20(bountyToken).transfer(msg.sender, toClaim);
    }

    function verifyOwners() internal {
        require(IGovernorBravo(GOVERNOR_BRAVO).admin() == TIMELOCK, "Timelock does not own governor bravo");
        require(ITimeLock(TIMELOCK).admin() == GOVERNOR_BRAVO, "GovernorBravo does not own timelock");
        require(IGaugeProxy(GAUGE_PROXY).ownership_admin() == TIMELOCK, "Timelock does not own gaugeproxy");
        require(IPoolProxy(POOL_PROXY).ownership_admin() == address(this), "Not owner");
        require(IPoolProxy(POOL_PROXY).future_ownership_admin() == address(this), "Not future owner");
    }

    function fixPool(address pool) internal {
        IPoolProxy proxy = IPoolProxy(POOL_PROXY);
        proxy.set_admin_fee(pool, ADMIN_FEE);
        proxy.set_deposit_fee(pool, DEPOSIT_FEE);
        proxy.set_fee(pool, SWAP_FEE);
        proxy.set_withdraw_fee(pool, WITHDRAW_FEE);
        proxy.set_dev_addr(pool, pool);
    }

    function checkGauge(address gauge) internal {
        require(IGauge(gauge).admin() == GAUGE_PROXY, "Incorrect gauge owner");
    }

    function checkGaugeController() internal {
        require(IGaugeController(GAUGE_CONTROLLER).admin() == GAUGE_PROXY && IGaugeController(GAUGE_CONTROLLER).future_admin() == GAUGE_PROXY, "Incorrect gauge controller owner");
    }

    function fixBurners() internal { 
        IPoolProxy(POOL_PROXY).set_many_burners(tokens_to_burners, burners);
    }

    function fixPoolProxy() internal {
        IPoolProxy proxy = IPoolProxy(POOL_PROXY);

        proxy.commit_set_admins(TIMELOCK, MOBI_MULTISIG);
        proxy.apply_set_admins();
    }

    function rewardBounty() internal {
        IERC20 token = IERC20(bountyToken);
        uint amount = token.balanceOf(address(this));
        token.transfer(EXPLOITER, amount);
    }

    function verifyBounty() external {
        verifyOwners();
        address[24] memory _pools = pools;
        address[23] memory _gauges = gauges;

        for (uint8 i =0; i < _pools.length; i++) {
            fixPool(_pools[i]);
        }

        for (uint8 i = 0; i < _gauges.length; i++) {
            checkGauge(_gauges[i]);
        }

        fixBurners();
        fixPoolProxy();
        checkGaugeController();

        rewardBounty();
    }


}
