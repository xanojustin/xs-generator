function "create_zoom_meeting" {
  input {
    text topic
    int duration
    text? start_time
  }
  stack {
    // Step 1: Get OAuth access token using Server-to-Server OAuth
    api.request {
      url = "https://zoom.us/oauth/token"
      method = "POST"
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ (($env.zoom_client_id ~ ":" ~ $env.zoom_client_secret)|base64_encode)
      ]
      params = {
        grant_type: "account_credentials",
        account_id: $env.zoom_account_id
      }
    } as $auth_response

    precondition ($auth_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with Zoom: " ~ ($auth_response.response.status|to_text)
    }

    var $access_token {
      value = $auth_response.response.result.access_token
    }

    // Step 2: Build the base meeting payload
    var $meeting_payload {
      value = {
        topic: $input.topic,
        duration: $input.duration,
        settings: {
          join_before_host: true,
          host_video: true,
          participant_video: true,
          mute_upon_entry: false,
          waiting_room: false
        }
      }
    }

    // Step 3: Conditionally add start_time if provided (creates scheduled meeting)
    // If start_time is provided, add it and set type to 2 (scheduled)
    // Otherwise, type 1 (instant) is used by default
    conditional {
      if ($input.start_time != null) {
        var $meeting_payload {
          value = ($meeting_payload)|set:"start_time":$input.start_time
        }
        var $meeting_payload {
          value = ($meeting_payload)|set:"type":2
        }
      }
    }

    api.request {
      url = "https://api.zoom.us/v2/users/me/meetings"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      params = $meeting_payload
    } as $meeting_response

    precondition ($meeting_response.response.status == 201) {
      error_type = "standard"
      error = "Failed to create Zoom meeting: " ~ ($meeting_response.response.status|to_text)
    }

    var $meeting {
      value = $meeting_response.response.result
    }

    // Step 4: Format the response
    var $result {
      value = {
        id: $meeting.id,
        topic: $meeting.topic,
        join_url: $meeting.join_url,
        start_url: $meeting.start_url,
        duration: $meeting.duration,
        created_at: $meeting.created_at
      }
    }
  }
  response = $result
}
