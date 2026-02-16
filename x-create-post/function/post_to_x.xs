function "post_to_x" {
  input {
    text text
  }
  stack {
    // Validate input
    precondition ($input.text != null && $input.text != "") {
      error_type = "inputerror"
      error = "Tweet text is required"
    }

    // X API v2 endpoint for creating tweets
    api.request {
      url = "https://api.twitter.com/2/tweets"
      method = "POST"
      params = {
        text: $input.text
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.X_ACCESS_TOKEN
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 201) {
        var $result {
          value = {
            success: true,
            tweet_id: $api_result.response.result.data.id,
            text: $api_result.response.result.data.text,
            created_at: now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid X API credentials. Check your access token."
        }
      }
      elseif ($api_result.response.status == 403) {
        throw {
          name = "AuthorizationError"
          value = "X API access denied. Ensure your app has write permissions."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "X API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.body|to_text)
        }
      }
    }
  }
  response = $result
}
