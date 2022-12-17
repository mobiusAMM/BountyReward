// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MobiusOwnershipTransfer {
    address constant TIMELOCK = 0x7d9Af9dF33D6CAB895B4cF3422D790cbE98B48c8;
    address constant POOL_PROXY = 0x1bc2DbB8c4d04AaCF4A7fefcDB060766964B5237;
    address constant GAUGE_PROXY = 0x0a3Ac12422C95F84b5bD18A6d9904d132a161C68;
    address constant GOVERNONR_BRAVO = 0xA5Eb84773633f33d442ECDaC48212B0dEBf3C84A;

    mapping(address => uint) deposits;

    address bountyToken;

    constructor(address _bountyToken) {
        bountyToken = _bountToken;
    }

    function deposit
}
