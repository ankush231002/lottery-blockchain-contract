// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract lottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value==1 ether);
        participants.push(payable(msg.sender));
    }
    function balance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,participants.length)));
    }
    function prizeWinner() public {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint x = random();
        address payable winner;
        uint no = x % participants.length;
        winner = participants[no];
        winner.transfer(balance());
        participants = new address payable[](0);
    }   
}
