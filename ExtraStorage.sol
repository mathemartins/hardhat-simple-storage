// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./SimpleStorageNew.sol";

// to be able to override a function, the function needs to be virtual
// override, virtual override
contract ExtraStorage is SimpleStorage {
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 7;
    }
}