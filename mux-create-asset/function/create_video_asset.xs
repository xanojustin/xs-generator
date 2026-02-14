function "create_video_asset" {
  input {
    text video_url
    text playback_policy?="public"
    bool test_mode?=false
  }
  stack {
    // Validate required inputs
    precondition ($input.video_url != null && $input.video_url != "") {
      error_type = "inputerror"
      error = "video_url is required"
    }

    // Validate environment variables
    precondition ($env.MUX_TOKEN_ID != null && $env.MUX_TOKEN_ID != "") {
      error_type = "standard"
      error = "MUX_TOKEN_ID environment variable is required"
    }

    precondition ($env.MUX_TOKEN_SECRET != null && $env.MUX_TOKEN_SECRET != "") {
      error_type = "standard"
      error = "MUX_TOKEN_SECRET environment variable is required"
    }

    // Build Basic Auth credentials (token_id:token_secret base64 encoded)
    var $credentials { value = $env.MUX_TOKEN_ID ~ ":" ~ $env.MUX_TOKEN_SECRET }
    var $auth_header { value = "Basic " ~ ($credentials|base64_encode) }

    // Build request payload
    var $payload {
      value = {
        input: [{ url: $input.video_url }],
        playback_policy: [$input.playback_policy],
        test: $input.test_mode
      }
    }

    // Create the asset via Mux API
    api.request {
      url = "https://api.mux.com/video/v1/assets"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $auth_header
      ]
      timeout = 60
    } as $api_result

    // Check for error response first
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Mux API error: " ~ ($api_result.response.status|to_text)
    }

    // Extract asset data from successful response
    var $asset_info { value = $api_result.response.result.data }

    // Build response data
    var $api_data {
      value = {
        success: true,
        asset_id: $asset_info.id,
        playback_ids: $asset_info.playback_ids,
        status: $asset_info.status,
        created_at: $asset_info.created_at,
        test_mode: $asset_info.test
      }
    }
  }
  response = $api_data
}
