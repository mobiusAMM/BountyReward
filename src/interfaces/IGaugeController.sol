// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IGaugeController {
    function admin() external returns (address);
    function future_admin() external returns (address);
}
