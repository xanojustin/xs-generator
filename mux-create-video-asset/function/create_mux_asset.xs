function "create_mux_asset" {
  input {
    text video_url
    text title
  }
  stack {
    // Validate inputs
    precondition ($input.video_url != null && $input.video_url != "") {
      error_type = "inputerror"
      error = "video_url is required"
    }

    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "title is required"
    }

    // Get environment variables
    var $mux_token_id { value = $env.MUX_TOKEN_ID }
    var $mux_token_secret { value = $env.MUX_TOKEN_SECRET }

    // Validate environment variables
    precondition ($mux_token_id != null && $mux_token_id != "") {
      error_type = "standard"
      error = "MUX_TOKEN_ID environment variable is required"
    }

    precondition ($mux_token_secret != null && $mux_token_secret != "") {
      error_type = "standard"
      error = "MUX_TOKEN_SECRET environment variable is required"
    }

    // Create Base64 auth token
    var $credentials { value = $mux_token_id ~ ":" ~ $mux_token_secret }
    var $auth_header { value = "Basic " ~ ($credentials|base64_encode) }

    // Create Mux asset via API
    api.request {
      url = "https://api.mux.com/video/v1/assets"
      method = "POST"
      params = {
        input: [
          {
            url: $input.video_url
          }
        ],
        playback_policy: ["public"],
        meta: {
          title: $input.title
        }
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $auth_header
      ]
      timeout = 60
    } as $mux_response

    // Check for API success
    conditional {
      if ($mux_response.response.status == 201) {
        var $asset_data { value = $mux_response.response.result.data }
        var $asset_id { value = $asset_data|get:"id":"" }
        var $playback_ids { value = $asset_data|get:"playback_ids":[] }
        var $playback_id { value = ($playback_ids|first)|get:"id":"" }
        var $status { value = $asset_data|get:"status":"" }

        // Store in database
        db.add "video_asset" {
          data = {
            mux_asset_id: $asset_id,
            title: $input.title,
            source_url: $input.video_url,
            playback_id: $playback_id,
            status: $status,
            created_at: now
          }
        } as $db_record

        // Build response
        var $result {
          value = {
            success: true,
            asset_id: $asset_id,
            playback_id: $playback_id,
            status: $status,
            playback_url: "https://stream.mux.com/" ~ $playback_id ~ ".m3u8",
            thumbnail_url: "https://image.mux.com/" ~ $playback_id ~ "/thumbnail.jpg",
            database_id: $db_record.id
          }
        }
      }
      else {
        var $error_message { value = "Mux API error: " ~ ($mux_response.response.status|to_text) }
        conditional {
          if ($mux_response.response.result != null) {
            var $mux_error { value = $mux_response.response.result|get:"error":{} }
            var $mux_error_msg { value = $mux_error|get:"message":"" }
            conditional {
              if ($mux_error_msg != "") {
                var.update $error_message { value = $error_message ~ " - " ~ $mux_error_msg }
              }
            }
          }
        }
        throw {
          name = "MuxAPIError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}