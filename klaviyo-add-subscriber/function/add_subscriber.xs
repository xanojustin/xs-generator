function "add_subscriber" {
  input {
    text email
    text first_name?=""
    text last_name?=""
    text list_id
    text phone_number?=""
  }

  stack {
    // Validate required inputs
    precondition ($input.email != "" && $input.email != null) {
      error_type = "inputerror"
      error = "email is required"
    }

    precondition ($input.list_id != "" && $input.list_id != null) {
      error_type = "inputerror"
      error = "list_id is required"
    }

    // Build the profile payload
    var $profile_attributes {
      value = {
        email: $input.email
      }
    }

    // Add optional fields if provided
    conditional {
      if ($input.first_name != "") {
        var $profile_attributes {
          value = $profile_attributes ~ {first_name: $input.first_name}
        }
      }
    }

    conditional {
      if ($input.last_name != "") {
        var $profile_attributes {
          value = $profile_attributes ~ {last_name: $input.last_name}
        }
      }
    }

    conditional {
      if ($input.phone_number != "") {
        var $profile_attributes {
          value = $profile_attributes ~ {phone_number: $input.phone_number}
        }
      }
    }

    // Build the full payload for Klaviyo API
    var $payload {
      value = {
        data: {
          type: "profile"
          attributes: $profile_attributes
        }
      }
    }

    // Create or update the profile via Klaviyo API
    api.request {
      url = "https://a.klaviyo.com/api/profile-import"
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Klaviyo-API-Key " ~ $env.KLAVIYO_API_KEY,
        "Content-Type: application/json",
        "revision: 2023-10-15"
      ]
      timeout = 30
    } as $klaviyo_profile_result

    // Handle profile creation response
    conditional {
      if ($klaviyo_profile_result.response.status == 200 || $klaviyo_profile_result.response.status == 201) {
        var $profile_id {
          value = $klaviyo_profile_result.response.result.data.id
        }

        // Now add the profile to the specified list
        var $list_payload {
          value = {
            data: [
              {
                type: "profile"
                id: $profile_id
              }
            ]
          }
        }

        api.request {
          url = "https://a.klaviyo.com/api/lists/" ~ $input.list_id ~ "/relationships/profiles"
          method = "POST"
          params = $list_payload
          headers = [
            "Authorization: Klaviyo-API-Key " ~ $env.KLAVIYO_API_KEY,
            "Content-Type: application/json",
            "revision: 2023-10-15"
          ]
          timeout = 30
        } as $klaviyo_list_result

        // Build the success response
        var $result {
          value = {
            success: true
            profile_id: $profile_id
            email: $input.email
            list_id: $input.list_id
            first_name: $input.first_name
            last_name: $input.last_name
            phone_number: $input.phone_number
            added_to_list: ($klaviyo_list_result.response.status == 200 || $klaviyo_list_result.response.status == 201)
          }
        }

        // Log the successful subscription
        db.add subscriber_log {
          data = {
            email: $input.email
            profile_id: $profile_id
            list_id: $input.list_id
            first_name: $input.first_name
            last_name: $input.last_name
            status: "success"
            created_at: now
          }
        } as $log_entry
      }
      else {
        // Handle profile creation error
        var $error_msg {
          value = "Klaviyo API error: " ~ ($klaviyo_profile_result.response.result.errors[0].detail ?? "Unknown error")
        }

        // Log the failed subscription attempt
        db.add subscriber_log {
          data = {
            email: $input.email
            list_id: $input.list_id
            first_name: $input.first_name
            last_name: $input.last_name
            status: "failed"
            error_message: $error_msg
            created_at: now
          }
        } as $log_entry

        throw {
          name = "KlaviyoAPIError"
          value = $error_msg
        }
      }
    }
  }

  response = $result
}