// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract Escrow {

    address agent;
    mapping(address => uint256) public deposits;

    modifier onlyAgent() {
        require(msg.sender == agent);
        _;
    }

    constructor() {
        agent = msg.sender;
    }

    // deposit funds into the escrow account
    function deposit(address payee) public onlyAgent payable {
        uint256 amount = msg.value;
        deposits[payee] += amount;
        // deposits[payee] = deposits[payee] + amount;
    }

    // withdraw funds from the escrow account
    function withdraw(address payable payee) public onlyAgent {
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }
}