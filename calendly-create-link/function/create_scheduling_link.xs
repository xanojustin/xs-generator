function "create_scheduling_link" {
  input {
    text event_type_uuid
    text email?
    text name?
  }
  stack {
    // Validate required inputs
    precondition ($input.event_type_uuid != null && $input.event_type_uuid != "") {
      error_type = "inputerror"
      error = "event_type_uuid is required"
    }

    // Build the invitee data if provided
    var $invitee_data { value = {} }
    
    conditional {
      if ($input.email != null && $input.email != "") {
        var.update $invitee_data { 
          value = $invitee_data|set:"email":$input.email 
        }
      }
    }
    
    conditional {
      if ($input.name != null && $input.name != "") {
        var.update $invitee_data { 
          value = $invitee_data|set:"name":$input.name 
        }
      }
    }

    // Build request payload
    var $payload { 
      value = { 
        event_type: "https://api.calendly.com/event_types/" ~ $input.event_type_uuid
      } 
    }
    
    conditional {
      if (($invitee_data|keys|count) > 0) {
        var.update $payload { 
          value = $payload|set:"invitee":$invitee_data 
        }
      }
    }

    // Call Calendly API to create scheduling link
    api.request {
      url = "https://api.calendly.com/scheduling_links"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.calendly_api_key
      ]
      timeout = 30
    } as $api_result

    // Handle response
    conditional {
      if ($api_result.response.status == 201) {
        // Success - extract the scheduling link
        var $scheduling_link { 
          value = $api_result.response.result.resource.booking_url 
        }
        var $link_response {
          value = {
            success: true,
            booking_url: $scheduling_link,
            event_type: $api_result.response.result.resource.event_type,
            status: $api_result.response.result.resource.status
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Calendly API key"
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFoundError"
          value = "Event type not found"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Calendly API error: " ~ ($api_result.response.status|to_text) ~ " - " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $link_response
}
