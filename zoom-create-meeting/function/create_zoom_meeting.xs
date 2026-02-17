// Zoom API - Create a Meeting
// Uses Zoom's Server-to-Server OAuth API to create meetings
function "create_zoom_meeting" {
  input {
    text topic
    text agenda?=""
    text start_time
    int duration?=60
    text timezone?="America/Los_Angeles"
    text password?=""
    bool waiting_room?=true
    bool join_before_host?=false
  }
  stack {
    // Get credentials from environment
    var $account_id { value = $env.ZOOM_ACCOUNT_ID }
    var $client_id { value = $env.ZOOM_CLIENT_ID }
    var $client_secret { value = $env.ZOOM_CLIENT_SECRET }
    
    // Validate required credentials
    precondition ($account_id != null && $account_id != "") {
      error_type = "standard"
      error = "ZOOM_ACCOUNT_ID environment variable is required"
    }
    
    precondition ($client_id != null && $client_id != "") {
      error_type = "standard"
      error = "ZOOM_CLIENT_ID environment variable is required"
    }
    
    precondition ($client_secret != null && $client_secret != "") {
      error_type = "standard"
      error = "ZOOM_CLIENT_SECRET environment variable is required"
    }
    
    // Step 1: Get OAuth access token
    var $auth_string { 
      value = $client_id ~ ":" ~ $client_secret 
    }
    var $auth_encoded { 
      value = $auth_string|base64_encode 
    }
    
    api.request {
      url = "https://zoom.us/oauth/token"
      method = "POST"
      params = {
        grant_type: "account_credentials",
        account_id: $account_id
      }
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ $auth_encoded
      ]
      timeout = 30
    } as $token_response
    
    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to authenticate with Zoom: " ~ ($token_response.response.status|to_text)
    }
    
    var $access_token { 
      value = $token_response.response.result.access_token 
    }
    
    // Step 2: Build meeting settings
    var $settings { 
      value = {
        waiting_room: $input.waiting_room,
        join_before_host: $input.join_before_host,
        mute_upon_entry: true,
        approval_type: 2
      }
    }
    
    // Add password if provided
    conditional {
      if ($input.password != null && $input.password != "") {
        var.update $settings { 
          value = $settings|set:"password":$input.password 
        }
      }
    }
    
    // Step 3: Build meeting payload
    var $meeting_payload {
      value = {
        topic: $input.topic,
        type: 2,
        start_time: $input.start_time,
        duration: $input.duration,
        timezone: $input.timezone,
        settings: $settings
      }
    }
    
    // Add agenda if provided
    conditional {
      if ($input.agenda != null && $input.agenda != "") {
        var.update $meeting_payload {
          value = $meeting_payload|set:"agenda":$input.agenda
        }
      }
    }
    
    // Step 4: Create the meeting via Zoom API
    api.request {
      url = "https://api.zoom.us/v2/users/me/meetings"
      method = "POST"
      params = $meeting_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      timeout = 30
    } as $meeting_response
    
    precondition ($meeting_response.response.status == 201) {
      error_type = "standard"
      error = "Failed to create Zoom meeting: " ~ ($meeting_response.response.status|to_text)
    }
    
    // Extract meeting details
    var $result {
      value = $meeting_response.response.result
    }
    
    var $meeting_info {
      value = {
        id: ($result|get:"id":""),
        topic: ($result|get:"topic":""),
        start_time: ($result|get:"start_time":""),
        duration: ($result|get:"duration":0),
        timezone: ($result|get:"timezone":""),
        join_url: ($result|get:"join_url":""),
        start_url: ($result|get:"start_url":""),
        password: ($result|get:"password":""),
        meeting_number: ($result|get:"id":0)
      }
    }
  }
  
  response = $meeting_info
}
