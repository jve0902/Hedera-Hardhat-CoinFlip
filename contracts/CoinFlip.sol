// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CoinFlip {
    address public owner;
    uint256 public betAmount;
    uint256 public feePercentage;
    uint256 public randomNumber;

    event CoinFlipped(address indexed player, bool result, uint256 winnings);

    constructor() {
        owner = msg.sender;
        betAmount = 0;
        feePercentage = 3;
    }

    function flipCoin(bool playerGuess) external payable {
        require(msg.value == betAmount, "Invalid bet amount");

        // Generate a random number between 0 and 1
        uint256 random = generateRandomNumber();

        bool result = (random == 0);

        if (result == playerGuess) {
            // Player wins
            uint256 winnings = (betAmount * 2) - calculateFee(betAmount);
            payable(msg.sender).transfer(winnings);
            emit CoinFlipped(msg.sender, true, winnings);
        } else {
            // Player loses
            uint256 winnings = calculateFee(betAmount);
            payable(owner).transfer(winnings);
            emit CoinFlipped(msg.sender, false, 0);
        }
    }

    function generateRandomNumber() public returns (uint) {
        bytes32 hash = keccak256(abi.encodePacked(block.timestamp, msg.sender, randomNumber));
        uint random = uint(hash) % 10;
        if (random < 5) {
            randomNumber = 1;
        } else {
            randomNumber = 0;
        }
        return randomNumber;
    }

    function calculateFee(uint256 amount) internal view returns (uint256) {
        return (amount * feePercentage) / 100;
    }

    function setBetAmount(uint256 amount) external {
        require(
            msg.sender == owner,
            "Only the contract owner can set the bet amount"
        );
        betAmount = amount;
    }
}
