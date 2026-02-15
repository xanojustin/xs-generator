function "send_postcard" {
  description = "Send a physical postcard via Lob API"
  input {
    text to_name filters=trim
    text to_address_line1 filters=trim
    text to_address_line2? filters=trim
    text to_city filters=trim
    text to_state filters=trim
    text to_zip filters=trim
    text to_country?="US" filters=trim
    text from_name filters=trim
    text from_address_line1 filters=trim
    text from_address_line2? filters=trim
    text from_city filters=trim
    text from_state filters=trim
    text from_zip filters=trim
    text from_country?="US" filters=trim
    text front_html filters=trim { description = "HTML content for the front of the postcard" }
    text back_html filters=trim { description = "HTML content for the back of the postcard" }
    text? size?="4x6" filters=trim { description = "Postcard size: 4x6, 6x9, or 6x11" }
    bool? use_test_mode?=true { description = "Use Lob test mode (true) or live mode (false)" }
  }
  stack {
    // Validate size parameter using switch
    switch ($input.size) {
      case ("4x6") {
        // Valid size
      }
      case ("6x9") {
        // Valid size
      }
      case ("6x11") {
        // Valid size
      }
      default {
        throw {
          name = "ValidationError"
          value = "Invalid postcard size. Must be one of: 4x6, 6x9, 6x11"
        }
      }
    }

    // Build the request payload for Lob API
    var $payload {
      value = {
        to: {
          name: $input.to_name,
          address_line1: $input.to_address_line1,
          address_city: $input.to_city,
          address_state: $input.to_state,
          address_zip: $input.to_zip,
          address_country: $input.to_country
        },
        from: {
          name: $input.from_name,
          address_line1: $input.from_address_line1,
          address_city: $input.from_city,
          address_state: $input.from_state,
          address_zip: $input.from_zip,
          address_country: $input.from_country
        },
        front: $input.front_html,
        back: $input.back_html,
        size: $input.size
      }
    }

    // Add optional address_line2 if provided
    conditional {
      if ($input.to_address_line2 != null && $input.to_address_line2 != "") {
        var.update $payload.to.address_line2 { value = $input.to_address_line2 }
      }
    }

    conditional {
      if ($input.from_address_line2 != null && $input.from_address_line2 != "") {
        var.update $payload.from.address_line2 { value = $input.from_address_line2 }
      }
    }

    // Determine which API key to use
    conditional {
      if ($input.use_test_mode) {
        var $api_key { value = $env.LOB_TEST_API_KEY }
      }
      else {
        var $api_key { value = $env.LOB_LIVE_API_KEY }
      }
    }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "Lob API key not configured. Set LOB_TEST_API_KEY or LOB_LIVE_API_KEY environment variable."
    }

    // Make the API request to Lob
    // Lob uses Basic Auth with API key as username and empty password
    var $auth_header { value = "Basic " ~ $api_key }

    api.request {
      url = "https://api.lob.com/v1/postcards"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $auth_header
      ]
      timeout = 30
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            postcard_id: $api_result.response.result.id,
            url: $api_result.response.result.url,
            expected_delivery_date: $api_result.response.result.expected_delivery_date,
            to: $api_result.response.result.to,
            from: $api_result.response.result.from,
            thumbnails: $api_result.response.result.thumbnails,
            mode: $api_result.response.result.mode
          }
        }
      }
      elseif ($api_result.response.status == 422) {
        var $result {
          value = {
            success: false,
            error: "Validation failed",
            details: $api_result.response.result.error,
            status_code: $api_result.response.status
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            error: "Lob API error",
            details: $api_result.response.result,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result
}
