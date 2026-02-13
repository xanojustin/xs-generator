function "zoom_create_meeting" {
  description = "Create a Zoom meeting using Server-to-Server OAuth"
  input {
    text topic filters=trim
    timestamp start_time?
    int duration?=30
    text timezone?="UTC" filters=trim
    text agenda? filters=trim
    text password? filters=trim|max:10
    bool waiting_room?=true
    text auto_recording?="none" filters=trim
  }
  stack {
    precondition (($input.topic|is_empty) == false) {
      error_type = "inputerror"
      error = "Meeting topic is required"
    }

    precondition ($input.duration > 0) {
      error_type = "inputerror"
      error = "Duration must be greater than 0 minutes"
    }

    precondition (($env.ZOOM_ACCOUNT_ID|is_empty) == false && ($env.ZOOM_CLIENT_ID|is_empty) == false && ($env.ZOOM_CLIENT_SECRET|is_empty) == false) {
      error_type = "standard"
      error = "Zoom credentials not configured. Please set ZOOM_ACCOUNT_ID, ZOOM_CLIENT_ID, and ZOOM_CLIENT_SECRET environment variables."
    }

    var $auth_string {
      value = $env.ZOOM_CLIENT_ID ~ ":" ~ $env.ZOOM_CLIENT_SECRET
    }

    api.request {
      url = "https://zoom.us/oauth/token"
      method = "POST"
      params = {
        grant_type: "account_credentials",
        account_id: $env.ZOOM_ACCOUNT_ID
      }
      headers = [
        "Authorization: Basic " ~ ($auth_string|base64_encode),
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $token_response

    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with Zoom: " ~ ($token_response.response.body.error ?? "Unknown error")
    }

    var $access_token {
      value = $token_response.response.body.access_token
    }

    conditional {
      if (($input.password|is_empty) == false) {
        var $meeting_password {
          value = $input.password
        }
      }
      else {
        var $meeting_password {
          value = "zoom" ~ ($input.duration|to_text)
        }
      }
    }

    var $request_body {
      value = {
        topic: $input.topic,
        type: 2,
        duration: $input.duration,
        timezone: $input.timezone,
        password: $meeting_password,
        settings: {
          waiting_room: $input.waiting_room,
          auto_recording: $input.auto_recording,
          join_before_host: false,
          mute_upon_entry: true
        }
      }
    }

    conditional {
      if ($input.start_time != null) {
        var $request_body {
          value = $request_body|set:"start_time":$input.start_time
        }
      }
    }

    conditional {
      if (($input.agenda|is_empty) == false) {
        var $request_body {
          value = $request_body|set:"agenda":$input.agenda
        }
      }
    }

    api.request {
      url = "https://api.zoom.us/v2/users/me/meetings"
      method = "POST"
      params = $request_body
      headers = [
        "Authorization: Bearer " ~ $access_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $zoom_response

    precondition ($zoom_response.response.status == 200 || $zoom_response.response.status == 201) {
      error_type = "standard"
      error = "Zoom API error: " ~ ($zoom_response.response.body.message ?? "Unknown error")
    }

    var $meeting_data {
      value = $zoom_response.response.body
    }
  }
  response = {
    success: true,
    meeting: {
      id: $meeting_data.id,
      topic: $meeting_data.topic,
      start_time: $meeting_data.start_time,
      duration: $meeting_data.duration,
      timezone: $meeting_data.timezone,
      join_url: $meeting_data.join_url,
      start_url: $meeting_data.start_url,
      password: $meeting_data.password,
      status: $meeting_data.status,
      created_at: $meeting_data.created_at
    }
  }
}
