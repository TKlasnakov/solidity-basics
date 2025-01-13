// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

 contract SimpleStorage {
    uint256 public myFavoriteNumber;
    uint256[] listOfNumbers;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(
            Person({name: _name, favoriteNumber: _favoriteNumber})
            );
    }

    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }
}  

