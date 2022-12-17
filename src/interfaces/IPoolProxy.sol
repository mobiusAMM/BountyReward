// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IPoolProxy {
    function ownership_admin() external returns (address);
    function future_ownership_admin() external returns (address);
    function future_emergency_admin() external returns (address);
    function emergency_admin() external returns (address);

    function set_many_burners(address[20] memory, address[20] memory) external;

    function transfer_ownership(address, address) external;
    function set_admin_fee(address, uint256) external;
    function set_fee(address, uint256) external;
    function set_deposit_fee(address, uint256) external;
    function set_withdraw_fee(address, uint256) external;
    function set_dev_addr(address, address) external;
}
