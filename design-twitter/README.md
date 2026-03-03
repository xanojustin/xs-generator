# Design Twitter

## Problem

Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and see the 10 most recent tweets in their news feed.

Implement the Twitter class:

- **`postTweet(userId, tweetId)`**: Compose a new tweet.
- **`getNewsFeed(userId)`**: Retrieve the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user follows or by the user themselves. Tweets must be ordered from most recent to least recent.
- **`follow(followerId, followeeId)`**: Follower follows a followee.
- **`unfollow(followerId, followeeId)`**: Follower unfollows a followee.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/twitter.xs`):** Contains the Twitter operations implementation

## Function Signature

- **Input:**
  - `operation` (text): The operation to perform - "postTweet", "getNewsFeed", "follow", or "unfollow"
  - `user_id` (int): The ID of the user performing the action
  - `tweet_id` (int, optional): The ID of the tweet (required for postTweet)
  - `followee_id` (int, optional): The ID of the user to follow/unfollow (required for follow/unfollow)

- **Output:**
  - For `getNewsFeed`: Returns `{success: true, operation: "getNewsFeed", feed: [tweet_ids...]}`
  - For other operations: Returns `{success: true, operation: "operation_name"}`
  - On error: Returns `{success: false, error: "error_message"}`

## Constraints

- All user IDs and tweet IDs are positive integers
- A user cannot follow themselves
- A user can follow the same user multiple times (idempotent - no duplicates)
- `getNewsFeed` returns at most 10 tweets

## Test Cases

| Operation | Input | Expected Output |
|-----------|-------|-----------------|
| postTweet | user_id: 1, tweet_id: 101 | success: true |
| postTweet | user_id: 2, tweet_id: 102 | success: true |
| getNewsFeed | user_id: 1 | Returns [5, 6, 1] (seed data tweets) |
| follow | user_id: 1, followee_id: 2 | success: true |
| getNewsFeed | user_id: 1 | Returns tweets from user 1 and user 2 |
| postTweet | user_id: 2, tweet_id: 103 | success: true |
| getNewsFeed | user_id: 1 | Now includes tweet 103 |
| unfollow | user_id: 1, followee_id: 2 | success: true |
| getNewsFeed | user_id: 1 | No longer shows user 2's tweets |

## Example Flow

```
// Initial state: User 1 follows User 2
// User 2 has tweets [1], User 1 has tweet [5], User 2 also has tweet [6]

getNewsFeed(1) -> [5, 6, 1]  // User 1's own tweet + followed User 2's tweets

postTweet(1, 101)
getNewsFeed(1) -> [101, 5, 6, 1]  // Most recent first

unfollow(1, 2)
getNewsFeed(1) -> [101, 5]  // Only User 1's tweets
```

## Algorithm

The solution uses:
- An array to store tweets with `{user_id, tweet_id, timestamp}` objects
- An object (dictionary) to store follow relationships: `{follower_id: [followee_ids]}`
- A timestamp counter to maintain chronological order

For `getNewsFeed`:
1. Get the list of users the current user follows (plus themselves)
2. Filter tweets to only include those from followed users
3. Sort by timestamp in descending order
4. Return the first 10 tweet IDs

Time Complexity:
- `postTweet`: O(1)
- `follow/unfollow`: O(1)  
- `getNewsFeed`: O(T log T) where T is total tweets (due to sorting)

Space Complexity: O(T + F) where T is total tweets and F is total follow relationships
