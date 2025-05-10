// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    address public alice = makeAddr("Alice"); // untuk bikin address atau ngedefinisiin ownernya. Bikin akun bernama alice

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_SetPrice() public {
        vm.prank(alice);                    // anggepannya kaya kita sebagai alice sekarang. prank sebagai Alice
        vm.expectRevert("Only owner can set price");  // ini unit test makanya harus SAMA PERSIS. Berekspektasi bahwa fungsi ini error. Yang akses itu cuman bisa owner
        counter.setPrice(100);

        vm.prank(address(this));            // prank sebagai owner
        counter.setPrice(100);
        assertEq(counter.price(), 100);
        console.log("Price set to 100");
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}


/*
CATATAN BLOCKCHAIN:
- liquiditas ada karena ada yang membeli dan menjual. Harus ada pasarnya. Yang membeli 
  stoknya pake dolar dan yang menjual stoknya pake dolar (menjual dalam bentuk dolar)
- Harus buat token dulu untuk menuju kesana. Token ini akan digunakan untuk transaksi di pasar
- Untuk membuat sesuatu yang 'berharga' (anggepannya kaya dolar Zimbabwe supaya dia jadi berharga) itu pake Erc20/ fungible 
  token. Pake library OpenZeppelin
- vault itu tempat penyimpanan. Punya fungsi utama untuk deposit. Nanti uang didepositkan ke vault. Nanti 
  ada fungsi withdraw yang nanti adminnya berfungsi untuk mendistribusikan keuntungan dengan fungsi deposite here
- Distribusi ini dilakukan secara proporsional sesuai dengan deposit yang dilakukan oleh masing-masing orang
- untuk update nilai saldonya, maka pake rumus shares math. Rumus deposit adalah "shares = deposit / totalAssets * totalShares"
- Rumus dari withdraw adalah "withdraw = shares / totalShares * totalAssets"
- MockUSDC akan deposit ke Vault. Pengguna harus punya MockUSDC untuk bisa deposit ke vault
- Umumnya user mengirim ke vault. Tapi kalo solidity itu vaultnya yang mengambil usdc dari user (vaultnya yang mengambil dari wallet user)
*/