function "create_profile" {
  description = "Create a profile in Klaviyo and optionally track an event"
  input {
    email email filters=lower
    text first_name?
    text last_name?
    text phone?
    text event_name?
  }
  stack {
    // Validate API key is configured
    precondition ($env.klaviyo_api_key != null && $env.klaviyo_api_key != "") {
      error_type = "standard"
      error = "Klaviyo API key is not configured. Set klaviyo_api_key environment variable."
    }

    // Build profile data object
    var $profile_data {
      value = {
        data: {
          type: "profile"
          attributes: {
            email: $input.email
          }
        }
      }
    }

    // Add optional fields if provided
    conditional {
      if ($input.first_name != null && $input.first_name != "") {
        var.update $profile_data.data.attributes {
          value = $profile_data.data.attributes|set:"first_name":$input.first_name
        }
      }
    }

    conditional {
      if ($input.last_name != null && $input.last_name != "") {
        var.update $profile_data.data.attributes {
          value = $profile_data.data.attributes|set:"last_name":$input.last_name
        }
      }
    }

    conditional {
      if ($input.phone != null && $input.phone != "") {
        var.update $profile_data.data.attributes {
          value = $profile_data.data.attributes|set:"phone_number":$input.phone
        }
      }
    }

    // Create profile in Klaviyo
    api.request {
      url = "https://a.klaviyo.com/api/profiles/"
      method = "POST"
      params = $profile_data
      headers = [
        "Content-Type: application/json",
        "Authorization: Klaviyo-API-Key " ~ $env.klaviyo_api_key,
        "revision: 2024-06-15"
      ]
      timeout = 30
    } as $profile_result

    // Handle profile creation response
    conditional {
      if ($profile_result.response.status == 201) {
        var $profile_id { value = $profile_result.response.result.data.id }
        var $profile_email { value = $profile_result.response.result.data.attributes.email }

        // Track event if event_name is provided
        conditional {
          if ($input.event_name != null && $input.event_name != "") {
            var $event_data {
              value = {
                data: {
                  type: "event"
                  attributes: {
                    metric: {
                      data: {
                        type: "metric"
                        attributes: {
                          name: $input.event_name
                        }
                      }
                    }
                    profile: {
                      data: {
                        type: "profile"
                        id: $profile_id
                      }
                    }
                    timestamp: now
                  }
                }
              }
            }

            api.request {
              url = "https://a.klaviyo.com/api/events/"
              method = "POST"
              params = $event_data
              headers = [
                "Content-Type: application/json",
                "Authorization: Klaviyo-API-Key " ~ $env.klaviyo_api_key,
                "revision: 2024-06-15"
              ]
              timeout = 30
            } as $event_result

            conditional {
              if ($event_result.response.status == 202) {
                var $event_tracked { value = true }
              }
              else {
                var $event_tracked { value = false }
                debug.log { value = "Event tracking failed: " ~ ($event_result.response.result|json_encode) }
              }
            }
          }
          else {
            var $event_tracked { value = null }
          }
        }

        // Build success response
        var $api_response {
          value = {
            success: true
            profile_id: $profile_id
            email: $profile_email
            event_tracked: $event_tracked
            message: "Profile created successfully in Klaviyo"
          }
        }
      }
      elseif ($profile_result.response.status == 409) {
        // Profile already exists
        var $api_response {
          value = {
            success: false
            error: "Profile already exists with this email"
            email: $input.email
          }
        }
      }
      else {
        // Other error
        var $api_response {
          value = {
            success: false
            error: "Failed to create profile"
            status: $profile_result.response.status
            details: $profile_result.response.result
          }
        }
      }
    }
  }
  response = $api_response
}
