function "bluesky_create_post" {
  description = "Create a post (skeet) on Bluesky using the AT Protocol"
  input {
    text text
    text[]? facets
  }
  stack {
    // Step 1: Authenticate with Bluesky to get access token
    api.request {
      url = "https://bsky.social/xrpc/com.atproto.server.createSession"
      method = "POST"
      params = {
        identifier: $env.bluesky_handle,
        password: $env.bluesky_password
      }
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $auth_response

    precondition ($auth_response.response.status == 200) {
      error_type = "standard"
      error = "Bluesky authentication failed: " ~ ($auth_response.response.status|to_text)
    }

    var $access_token { value = $auth_response.response.result.accessJwt }
    var $did { value = $auth_response.response.result.did }

    // Step 2: Build the post record
    var $post_record {
      value = {
        text: $input.text,
        createdAt: now|format_timestamp:"Y-m-d\\TH:i:s.v\\Z":"UTC",
        $type: "app.bsky.feed.post"
      }
    }

    // Add facets (links, mentions, hashtags) if provided
    conditional {
      if ($input.facets != null && ($input.facets|count) > 0) {
        var.update $post_record {
          value = $post_record|set:"facets":$input.facets
        }
      }
    }

    // Step 3: Create the post on Bluesky
    api.request {
      url = "https://bsky.social/xrpc/com.atproto.repo.createRecord"
      method = "POST"
      params = {
        repo: $did,
        collection: "app.bsky.feed.post",
        record: $post_record
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      timeout = 30
    } as $post_response

    precondition ($post_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to create Bluesky post: " ~ ($post_response.response.result|json_encode)
    }

    var $post_result { value = $post_response.response.result }
  }
  response = $post_result
}
