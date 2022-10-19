// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// contract is like class in other programming languages
contract SimpleStorage {
    // boolean(true or false), uint(positive integers), int(positive or negative), address(address), bytes(chars)
    // bool hasFavoriteNumber = true;
    // uint256 favoriteNumber = 123;
    // int256 anotherNumber = 321;
    // string favoriteNumberInText = "Five";
    // address myAddress = 0x295d0a96719Dc8ceBF978F657683D75F1866D67b;
    // bytes32 favoriteByte = "cat";

    // Automatically initialized to zero
    // if you don't set visibilty to the smart contract it is automatically set as internal and cannot be seen otherwise
    // variable creation format ( type visibility name )
    uint256 public favoriteNumber;
    People public person = People({favoriteNumber: 2, name: "Martins"});

    // struct is used to create objects and object types, think of struct like class without methods
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // mapping are like dictionaries in other programming language
    mapping(string => uint256) public  nameToFavoriteNumber;
    
    // uint256[] public favoriteNumbersList;
    // dynamic list[] - unlimited number of objects and fixed list[4] - limited to the content
    People[] public people;

    // memory, calldata, storage
    // calldata - temporary variables that cannot be modified
    // memory - temporary variables that can be modified
    // storage - parmanent variables that can be modified
    function addPeople(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    // when a function does quite a fairly complex job the more expensive it would cost to execute on the chain
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // functions having view, pure doesn't neccessarily consume gas and almost insignificant
    // cos we are reading the chain or state of the chain and not writing to the chain
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    // pure functions doesn't read the chain, they read the contract and run during compilation
    function add() public pure returns(uint256) {
        return (1+1);
    }

    //0xd9145CCE52D386f254917e481eB44e9943F39138

}