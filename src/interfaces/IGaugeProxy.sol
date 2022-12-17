// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IGaugeProxy {
    function ownership_admin() external returns (address);
    function future_ownership_admin() external returns (address);
    function future_emergency_admin() external returns (address);
    function emergency_admin() external returns (address);

    function commit_transfer_ownership(address, address) external;
    function accept_transfer_ownership(address) external;
    function set_killed(address, bool) external;
}
