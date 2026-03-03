function "twitter" {
  description = "Design a simplified Twitter with post tweet, get news feed, follow and unfollow operations"
  input {
    text operation
    int user_id
    int? tweet_id
    int? followee_id
  }
  stack {
    // Global storage for tweets and follows using var
    // tweets: array of {user_id, tweet_id, timestamp}
    // follows: object where key is follower_id, value is array of followee_ids
    // timestamp counter for ordering

    var $tweets { value = [] }
    var $follows { value = {} }
    var $timestamp { value = 0 }

    // Initialize with some seed data for testing
    // User 1 follows User 2
    var.update $follows { value = $follows|set:"1":[2] }
    
    // Some initial tweets
    var.update $timestamp { value = $timestamp + 1 }
    var.update $tweets { 
      value = $tweets|merge:[{user_id: 2, tweet_id: 1, timestamp: $timestamp}]
    }
    var.update $timestamp { value = $timestamp + 1 }
    var.update $tweets { 
      value = $tweets|merge:[{user_id: 1, tweet_id: 5, timestamp: $timestamp}]
    }
    var.update $timestamp { value = $timestamp + 1 }
    var.update $tweets { 
      value = $tweets|merge:[{user_id: 2, tweet_id: 6, timestamp: $timestamp}]
    }

    // Process the operation
    switch ($input.operation) {
      case ("postTweet") {
        // Post a new tweet
        var.update $timestamp { value = $timestamp + 1 }
        var $new_tweet { 
          value = {user_id: $input.user_id, tweet_id: $input.tweet_id, timestamp: $timestamp}
        }
        var.update $tweets { value = $tweets|merge:[$new_tweet] }
        var $result { value = {success: true, operation: "postTweet"} }
      } break
      
      case ("getNewsFeed") {
        // Get the 10 most recent tweets from user and their followees
        var $user_id_text { value = $input.user_id|to_text }
        var $following { value = ($follows|get:$user_id_text:[])|merge:[$input.user_id] }
        
        // Filter tweets from followed users + self
        var $relevant_tweets {
          value = $tweets|filter:(($following|contains:$$.user_id) == true)
        }
        
        // Sort by timestamp descending (most recent first)
        var $sorted_tweets {
          value = $relevant_tweets|sort:"timestamp":"desc"
        }
        
        // Take first 10 and extract tweet_ids
        var $limited_tweets {
          value = $sorted_tweets|slice:0:10
        }
        
        var $feed {
          value = $limited_tweets|map:$$.tweet_id
        }
        
        var $result { value = {success: true, operation: "getNewsFeed", feed: $feed} }
      } break
      
      case ("follow") {
        // Follow a user
        var $follower_text { value = $input.user_id|to_text }
        var $current_following { value = $follows|get:$follower_text:[] }
        
        conditional {
          if (!(($current_following|contains:$input.followee_id) == true)) {
            var $updated_following { value = $current_following|merge:[$input.followee_id] }
            var.update $follows { value = $follows|set:$follower_text:$updated_following }
          }
        }
        
        var $result { value = {success: true, operation: "follow"} }
      } break
      
      case ("unfollow") {
        // Unfollow a user
        var $follower_text { value = $input.user_id|to_text }
        var $current_following { value = $follows|get:$follower_text:[] }
        
        var $updated_following {
          value = $current_following|filter:($$ != $input.followee_id)
        }
        
        var.update $follows { value = $follows|set:$follower_text:$updated_following }
        var $result { value = {success: true, operation: "unfollow"} }
      } break
      
      default {
        var $result { value = {success: false, error: "Unknown operation"} }
      }
    }
  }
  response = $result
}
