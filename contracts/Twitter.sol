// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Twitter {
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping (address => Tweet[]) tweets;
    address internal owner;
    uint16  MAX_TWEET_LENGHT = 280;

    event TweetCreated(address author, uint256 indexed id, string content, uint256 indexed timestamp);
    event TweetLiked(address liker, address author, uint256 tweetId, string content, uint256 tweetLikes);
    event TweetDisliked(address liker, address author, uint256 tweetId, string content, uint256 tweetLikes);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'You are not the owner!');
        _;
    }

    function createTweet(string memory _tweet) external {

        require(bytes(_tweet).length <= MAX_TWEET_LENGHT, 'Tweet too long');

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

         tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.author, newTweet.id, newTweet.content, newTweet.timestamp);     

    }

    function changeTweetLength(uint16 newTweetLength) external {
        MAX_TWEET_LENGHT = newTweetLength;
    }
}