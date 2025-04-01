// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Rating {

    address owner;
    string[] users;
    mapping(string => User_Details) rating;

    //set deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    //only owner can run
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //checks if user has been added
    modifier isInitiated(string memory _username) {
        require(rating[_username].isInitited > 0);
        _;
    }

    //checks if both users exist
    modifier bothInitiated(string memory _ratingFrom, string memory _ratingto) {
        require(rating[_ratingFrom].isInitited > 0 && rating[_ratingto].isInitited > 0);
        _;
    }

    //stores each user's rating info
    struct User_Details {
        uint rating_total; //total points received
        uint times_voted; //how many times they've been rated
        uint isInitited; //used to check if user exists
    }

    //not used in this version, but may be for future tracking
    struct Rate_User {
        uint unique_id;
        uint rating;
    }

    //logs every rating given
    event RatingActivity(
        string indexed rating_from,
        string indexed rating_to,
        uint rating
    );

    //adds a new user
    function addUser(string memory _username) public onlyOwner {
        users.push(_username);
        rating[_username].rating_total = 0;
        rating[_username].isInitited = 1;
        rating[_username].times_voted = 0;
    }

    //returns how many users are added
    function getUserSize() public view returns (uint) {
        return users.length;
    }

    //gets total rating points for a user
    function getUserRating(string memory _username) public view isInitiated(_username) returns (uint) {
        return rating[_username].rating_total;
    }

    //gets how many times a user has been rated
    function getUserTimesVoted(string memory _username) public view isInitiated(_username) returns (uint) {
        return rating[_username].times_voted;
    }

    //adds a rating from one user to another
    function addRating(string memory _ratingFrom, string memory _userRated, uint256 data) public bothInitiated(_ratingFrom, _userRated) {
        rating[_userRated].rating_total += data;
        rating[_userRated].times_voted++;
        emit RatingActivity(_ratingFrom, _userRated, data);
    }

    //returns the integer average rating
    function getIntegerRating(string memory _userRated) public view returns (uint256) {
        uint total = rating[_userRated].rating_total;
        uint rate_count = rating[_userRated].times_voted;
        uint int_rating = div(total, rate_count);
        return int_rating;
    }

    //returns both total and times voted
    function getRatingParameters(string memory _userRated) public view returns (uint, uint) {
        return (rating[_userRated].rating_total, rating[_userRated].times_voted);
    }

    //basic division with a check
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }
}
