// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    uint256 public favoriteNumber;
    mapping (string => uint256) nameToFavoriteNumber;
    
    struct People {
        string name;
        uint256 favoriteNumber;
    }

    People[] public people;

    function retrieveFavoriteNumber() public view returns(uint256) {
        return favoriteNumber;
    }

    function storeFavoriteNumber(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function addPeopleToArray(string memory _name, uint256 _favoriteNumber) public virtual {
        People memory person = People({name: _name, favoriteNumber: _favoriteNumber});
        people.push(person);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}