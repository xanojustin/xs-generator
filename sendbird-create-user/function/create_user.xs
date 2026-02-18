function "create_user" {
  description = "Create a new user in Sendbird chat platform"
  input {
    text user_id filters=trim
    text nickname filters=trim
    text profile_url?=""
  }
  
  stack {
    precondition ($input.user_id != "") {
      error_type = "inputerror"
      error = "User ID is required"
    }
    
    precondition ($input.nickname != "") {
      error_type = "inputerror"
      error = "Nickname is required"
    }
    
    var $api_token { value = $env.SENDBIRD_API_TOKEN }
    var $app_id { value = $env.SENDBIRD_APP_ID }
    
    precondition ($api_token != null && $api_token != "") {
      error_type = "standard"
      error = "SENDBIRD_API_TOKEN environment variable is required"
    }
    
    precondition ($app_id != null && $app_id != "") {
      error_type = "standard"
      error = "SENDBIRD_APP_ID environment variable is required"
    }
    
    var $payload {
      value = {
        user_id: $input.user_id,
        nickname: $input.nickname,
        profile_url: $input.profile_url
      }
    }
    
    debug.log { value = "Creating Sendbird user: " ~ $input.user_id }
    
    api.request {
      url = "https://api-" ~ $app_id ~ ".sendbird.com/v3/users"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Api-Token: " ~ $api_token
      ]
    } as $api_result
    
    debug.log { value = "Sendbird API response status: " ~ ($api_result.response.status|to_text) }
    
    conditional {
      if ($api_result.response.status == 400) {
        throw {
          name = "SendbirdError"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "SendbirdError"
          value = "Authentication failed - check your API token"
        }
      }
      elseif ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $user_data { value = $api_result.response.result }
        
        var $result {
          value = {
            success: true,
            user_id: $user_data|get:"user_id":"",
            nickname: $user_data|get:"nickname":"",
            profile_url: $user_data|get:"profile_url":"",
            is_active: $user_data|get:"is_active":false,
            created_at: $user_data|get:"created_at":0
          }
        }
      }
      else {
        throw {
          name = "SendbirdError"
          value = "API error (" ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}
