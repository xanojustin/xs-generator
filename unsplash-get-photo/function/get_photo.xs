function "get_photo" {
  description = "Fetch a random photo from Unsplash API"
  input {
    text query?="nature" filters=trim { description = "Search query for photos (default: nature)" }
    text orientation?="landscape" filters=trim { description = "Photo orientation: landscape, portrait, squarish (default: landscape)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.UNSPLASH_ACCESS_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "UNSPLASH_ACCESS_KEY environment variable not configured"
    }

    // Validate orientation value
    conditional {
      if ($input.orientation != "landscape" && $input.orientation != "portrait" && $input.orientation != "squarish") {
        var $orientation { value = "landscape" }
      }
      else {
        var $orientation { value = $input.orientation }
      }
    }

    // Build the request URL with query parameters
    var $url {
      value = "https://api.unsplash.com/photos/random?query=" ~ ($input.query|url_encode) ~ "&orientation=" ~ $orientation
    }

    // Send the request to Unsplash API
    api.request {
      url = $url
      method = "GET"
      headers = [
        "Authorization: Client-ID " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $photo_id { value = null }
    var $photo_url { value = null }
    var $photo_thumb { value = null }
    var $description { value = null }
    var $alt_description { value = null }
    var $photographer_name { value = null }
    var $photographer_username { value = null }
    var $unsplash_link { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $photo_id { value = $response_body|get:"id" }
        var $description { value = $response_body|get:"description" }
        var $alt_description { value = $response_body|get:"alt_description" }
        var $unsplash_link { value = $response_body|get:"links"|get:"html" }

        // Extract URLs from the response
        var $urls { value = $response_body|get:"urls" }
        conditional {
          if ($urls != null) {
            var $photo_url { value = $urls|get:"regular" }
            var $photo_thumb { value = $urls|get:"small" }
          }
        }

        // Extract photographer info
        var $user { value = $response_body|get:"user" }
        conditional {
          if ($user != null) {
            var $photographer_name { value = $user|get:"name" }
            var $photographer_username { value = $user|get:"username" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Unsplash API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_array { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($error_array != null && ($error_array|is_array)) {
                var $error_message {
                  value = $error_array|first
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    photo_id: $photo_id,
    photo_url: $photo_url,
    photo_thumb: $photo_thumb,
    description: $description,
    alt_description: $alt_description,
    photographer_name: $photographer_name,
    photographer_username: $photographer_username,
    unsplash_link: $unsplash_link,
    error: $error_message
  }
}
