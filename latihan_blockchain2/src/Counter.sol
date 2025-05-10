// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;  // disimpan di memori/ database website
    uint256 public price;   // anggepannya ini tu variabelnya

    address public owner;   // variabel yang menyimpan owner (?)

    constructor() {
        owner = msg.sender; // saat class ini dijalanlkan, dia bakalan ngecreate ownernya siapa
    }

    function setPrice(uint256 newPrice) public { // untuk ngubah nilai variabel price
        require(msg.sender == owner, "Only owner can set price"); // ngatur supaya hanya owner yang bisa set harga
        price = newPrice;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
