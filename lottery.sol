// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lottery{
    address public manager;
    address payable[] public participants;
    address payable public winner;
    constructor(){
        manager=msg.sender;
    }

    receive() external payable { 
        require(msg.value==0.001 ether);
        participants.push(payable(msg.sender));
    }

    function getwinner() public returns(address payable){
        require(msg.sender==manager);
        require(participants.length > 0);
        winner=participants[(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender)))) % participants.length];
        winner.transfer(address(this).balance);
        delete participants;
        return winner;
    }
}
