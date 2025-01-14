/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract LotteryDApp {  
    address public owner;  
    mapping(address => bool) public whitelisted;  
    mapping(address => bool) public hasParticipated;  
    address[] public participants;  
    uint public startTime;  
    uint public endTime;  
    uint public prizePool;  

    event Whitelisted(address indexed user);  
    event EnterLottery(address indexed user);  
    event WinnerChosen(address indexed winner, uint prize);  

    modifier onlyOwner() {  
        require(msg.sender == owner, "Only owner can perform this action");  
        _;  
    }  

    modifier withinTimeFrame() {  
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Lottery is not active");  
        _;  
    }  

    constructor(uint _startTime, uint _duration) {  
        owner = msg.sender;  
        startTime = _startTime;  
        endTime = _startTime + _duration;  
    }  

    function whitelistAddress(address _user) public onlyOwner {  
        whitelisted[_user] = true;  
        emit Whitelisted(_user);  
    }  

    function enterLottery() public payable withinTimeFrame {  
        require(whitelisted[msg.sender], "You are not whitelisted");  
        require(!hasParticipated[msg.sender], "You have already participated");  
        require(msg.value == 0.1 ether, "Entry fee is 0.1 ETH");  

        participants.push(msg.sender);  
        hasParticipated[msg.sender] = true;  
        prizePool += msg.value;  

        emit EnterLottery(msg.sender);  
    }  

    function chooseWinner() public onlyOwner {  
        require(block.timestamp > endTime, "Lottery is still ongoing");  
        require(participants.length > 0, "No participants in the lottery");  

        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, participants.length))) % participants.length;  
        address winner = participants[randomIndex];  

        (bool success, ) = winner.call{value: prizePool}("");  
        require(success, "Transfer to winner failed");  

        emit WinnerChosen(winner, prizePool);  

        // Reset the lottery  
        participants = new address[](0);      
         prizePool = 0;  
    }  
}
