function "create_booking" {
  input {
    int event_type_id
    text start_time
    object attendee {
      schema {
        text name
        text email
        text time_zone
      }
    }
    text? title
    text? description
    text? location
  }

  stack {
    // Validate required inputs
    precondition ($input.event_type_id > 0) {
      error_type = "inputerror"
      error = "event_type_id is required and must be greater than 0"
    }

    precondition ($input.start_time != null && $input.start_time != "") {
      error_type = "inputerror"
      error = "start_time is required"
    }

    precondition ($input.attendee != null && $input.attendee.email != null && $input.attendee.email != "") {
      error_type = "inputerror"
      error = "attendee.email is required"
    }

    // Get environment variables
    var $api_key { value = $env.CALCOM_API_KEY }
    var $base_url { value = $env.CALCOM_BASE_URL ?? "https://api.cal.com/v2" }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "CALCOM_API_KEY environment variable is required"
    }

    // Build the request payload
    var $payload {
      value = {
        event_type_id: $input.event_type_id,
        start: $input.start_time,
        attendee: {
          name: $input.attendee.name,
          email: $input.attendee.email,
          time_zone: $input.attendee.time_zone
        }
      }
    }

    // Add optional fields if provided
    conditional {
      if ($input.title != null && $input.title != "") {
        var.update $payload { value = $payload|set:"title":$input.title }
      }
    }

    conditional {
      if ($input.description != null && $input.description != "") {
        var.update $payload { value = $payload|set:"description":$input.description }
      }
    }

    conditional {
      if ($input.location != null && $input.location != "") {
        var.update $payload { value = $payload|set:"location":$input.location }
      }
    }

    // Make the API request to Cal.com
    api.request {
      url = ($base_url) ~ "/bookings"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Check for API errors
    conditional {
      if ($api_result.response.status >= 400) {
        var $error_message { value = "Cal.com API error: " ~ ($api_result.response.status|to_text) }
        conditional {
          if ($api_result.response.result != null && $api_result.response.result.message != null) {
            var.update $error_message { value = $error_message ~ " - " ~ $api_result.response.result.message }
          }
        }
        throw {
          name = "CalComAPIError"
          value = $error_message
        }
      }
    }

    // Extract booking data
    var $booking {
      value = $api_result.response.result.data ?? $api_result.response.result
    }

    // Build response
    var $response_data {
      value = {
        success: true,
        booking: $booking
      }
    }
  }

  response = $response_data
}
