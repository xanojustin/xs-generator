function "fetch_reddit_posts" {
  description = "Fetch hot posts from a Reddit subreddit"
  input {
    text subreddit filters=trim|lower {
      description = "Name of the subreddit to fetch posts from (without r/)"
    }
    text sort_by filters=trim|lower {
      description = "Sort order: hot, new, top, rising"
    }
    int limit filters=min:1|max:100 {
      description = "Number of posts to fetch (max 100)"
    }
  }
  stack {
    // Validate inputs
    precondition (($input.subreddit|count) > 0) {
      error_type = "standard"
      error = "Subreddit name is required"
    }
    
    // Set default sort if not provided
    conditional {
      if (`$input.sort_by == ""`) {
        var $sort { value = "hot" }
      }
      else {
        var $sort { value = $input.sort_by }
      }
    }
    
    // Set default limit if not provided or invalid
    conditional {
      if (`$input.limit <= 0 || $input.limit > 100`) {
        var $post_limit { value = 25 }
      }
      else {
        var $post_limit { value = $input.limit }
      }
    }
    
    // Construct the Reddit API URL
    var $url { 
      value = "https://www.reddit.com/r/" ~ $input.subreddit ~ "/" ~ $sort ~ ".json?limit=" ~ ($post_limit|to_text)
    }
    
    // Make the API request to Reddit
    api.request {
      url = $url
      method = "GET"
      headers = ["User-Agent: XanoRunJob/1.0"]
    } as $reddit_response
    
    // Check if the request was successful
    precondition ($reddit_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to fetch posts from Reddit: " ~ ($reddit_response.response.status|to_text)
    }
    
    // Extract the posts data
    var $posts_data { value = $reddit_response.response.result.data.children }
    
    // Transform the data into a cleaner format
    var $formatted_posts { value = [] }
    
    foreach ($posts_data) {
      each as $post {
        var $post_info { value = $post.data }
        var $formatted_post {
          value = {
            id: ($post_info|get:"id"),
            title: ($post_info|get:"title"),
            author: ($post_info|get:"author"),
            score: ($post_info|get:"score"),
            num_comments: ($post_info|get:"num_comments"),
            url: ($post_info|get:"url"),
            permalink: "https://reddit.com" ~ ($post_info|get:"permalink"),
            created_utc: ($post_info|get:"created_utc"),
            subreddit: ($post_info|get:"subreddit"),
            is_self: ($post_info|get:"is_self"),
            selftext: ($post_info|get:"selftext")
          }
        }
        var $formatted_posts {
          value = $formatted_posts ~ [$formatted_post]
        }
      }
    }
    
    // Prepare the response
    var $result {
      value = {
        subreddit: $input.subreddit,
        sort_by: $sort,
        total_posts: ($formatted_posts|count),
        posts: $formatted_posts
      }
    }
  }
  response = $result
}