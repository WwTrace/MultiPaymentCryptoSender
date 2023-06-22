// SPDX-License-Identifier: GNU GENERAL PUBLIC LICENSE

pragma solidity 0.8.18;

contract MultiPaymentSender {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function distribute(address[] memory to) public payable onlyOwner {
        require(to.length > 0, "Empty address array");
        require(msg.value > 0, "No msg value");
        for (uint256 i = 0; i < to.length; i++) {
            payable(to[i]).transfer(msg.value / to.length);
        }
    }
}
