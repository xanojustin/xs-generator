function "reddit_submit_post" {
  description = "Submit a post to a subreddit using the Reddit API"
  input {
    text subreddit filters=trim|lower {
      description = "Name of the subreddit to post to (without r/)"
    }
    text title filters=trim {
      description = "Title of the post"
    }
    text content? filters=trim {
      description = "Text content for self posts (optional if URL provided)"
    }
    text url? filters=trim {
      description = "URL for link posts (optional if content provided)"
    }
    text kind?=self {
      description = "Post type: 'self' for text posts, 'link' for URL posts"
    }
    bool nsfw?=false {
      description = "Mark post as NSFW"
    }
    bool spoiler?=false {
      description = "Mark post as spoiler"
    }
  }
  stack {
    precondition (($input.subreddit|is_empty) == false) {
      error_type = "inputerror"
      error = "Subreddit name is required"
    }

    precondition (($input.title|is_empty) == false) {
      error_type = "inputerror"
      error = "Post title is required"
    }

    precondition (($input.title|strlen) <= 300) {
      error_type = "inputerror"
      error = "Post title must be 300 characters or less"
    }

    precondition ($input.kind == "self" || $input.kind == "link") {
      error_type = "inputerror"
      error = "Post kind must be 'self' or 'link'"
    }

    conditional {
      if ($input.kind == "self") {
        precondition (($input.content|is_empty) == false) {
          error_type = "inputerror"
          error = "Content is required for self/text posts"
        }
      }
      else {
        precondition (($input.url|is_empty) == false) {
          error_type = "inputerror"
          error = "URL is required for link posts"
        }
      }
    }

    var $credentials {
      value = ($env.reddit_client_id ~ ":" ~ $env.reddit_client_secret)|base64_encode
    }

    api.request {
      url = "https://www.reddit.com/api/v1/access_token"
      method = "POST"
      headers = [
        "Authorization: Basic " ~ $credentials,
        "Content-Type: application/x-www-form-urlencoded",
        "User-Agent: XanoScriptRunJob/1.0"
      ]
      params = {
        grant_type: "password",
        username: $env.reddit_username,
        password: $env.reddit_password
      }
      timeout = 30
    } as $token_response

    var $token_status {
      value = $token_response.response.status
    }

    precondition ($token_status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with Reddit: " ~ $token_response.response.body.error
    }

    var $access_token {
      value = $token_response.response.body.access_token
    }

    var $post_params {
      value = {
        sr: $input.subreddit,
        title: $input.title,
        kind: $input.kind
      }
    }

    conditional {
      if ($input.kind == "self") {
        var.update $post_params {
          value = $post_params|set:"text":$input.content
        }
      }
      else {
        var.update $post_params {
          value = $post_params|set:"url":$input.url
        }
      }
    }

    conditional {
      if ($input.nsfw) {
        var.update $post_params {
          value = $post_params|set:"nsfw":true
        }
      }
    }

    conditional {
      if ($input.spoiler) {
        var.update $post_params {
          value = $post_params|set:"spoiler":true
        }
      }
    }

    api.request {
      url = "https://oauth.reddit.com/api/submit"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $access_token,
        "Content-Type: application/x-www-form-urlencoded",
        "User-Agent: XanoScriptRunJob/1.0"
      ]
      params = $post_params
      timeout = 30
    } as $submit_response

    var $submit_status {
      value = $submit_response.response.status
    }

    var $submit_body {
      value = $submit_response.response.body
    }

    precondition ($submit_status == 200) {
      error_type = "standard"
      error = "Failed to submit post: " ~ $submit_body.error
    }

    var $success {
      value = $submit_body.json.data != null
    }

    conditional {
      if ($success == false) {
        throw {
          name = "RedditAPIError"
          value = $submit_body.json.errors|first|first
        }
      }
    }

    var $post_id {
      value = $submit_body.json.data.id
    }

    var $post_url {
      value = "https://www.reddit.com/r/" ~ $input.subreddit ~ "/comments/" ~ $post_id
    }

    var $result {
      value = {
        success: true,
        post_id: $post_id,
        post_url: $post_url,
        subreddit: $input.subreddit,
        title: $input.title,
        kind: $input.kind
      }
    }
  }
  response = $result
}
