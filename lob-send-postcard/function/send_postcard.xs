function "send_postcard" {
  description = "Send a physical postcard using the Lob API"
  
  input {
    text to_name filters=trim
    text to_address_line1 filters=trim
    text to_address_line2? filters=trim
    text to_city filters=trim
    text to_state filters=trim
    text to_zip filters=trim
    text front_image_url filters=trim
    text back_message filters=trim
  }
  
  stack {
    // Validate required inputs
    precondition ($input.to_name != "" && $input.to_name != null) {
      error_type = "inputerror"
      error = "Recipient name is required"
    }
    
    precondition ($input.to_address_line1 != "" && $input.to_address_line1 != null) {
      error_type = "inputerror"
      error = "Address line 1 is required"
    }
    
    precondition ($input.to_city != "" && $input.to_city != null) {
      error_type = "inputerror"
      error = "City is required"
    }
    
    precondition ($input.to_state != "" && $input.to_state != null) {
      error_type = "inputerror"
      error = "State is required"
    }
    
    precondition ($input.to_zip != "" && $input.to_zip != null) {
      error_type = "inputerror"
      error = "ZIP code is required"
    }
    
    precondition ($input.front_image_url != "" && $input.front_image_url != null) {
      error_type = "inputerror"
      error = "Front image URL is required"
    }
    
    // Build the request payload
    var $payload {
      value = {
        description: "Xano Postcard",
        to: {
          name: $input.to_name,
          address_line1: $input.to_address_line1,
          address_city: $input.to_city,
          address_state: $input.to_state,
          address_zip: $input.to_zip,
          address_country: "US"
        },
        front: $input.front_image_url,
        back: $input.back_message
      }
    }
    
    // Add optional address line 2 if provided
    conditional {
      if ($input.to_address_line2 != null && $input.to_address_line2 != "") {
        var $to_with_line2 {
          value = $payload|get:"to"|set:"address_line2":$input.to_address_line2
        }
        var.update $payload {
          value = $payload|set:"to":$to_with_line2
        }
      }
    }
    
    // Make the API request to Lob
    api.request {
      url = "https://api.lob.com/v1/postcards"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($env.LOB_API_KEY ~ ":"|base64_encode)
      ]
      timeout = 60
    } as $api_result
    
    // Check for success (Lob returns 200 for successful postcard creation)
    conditional {
      if ($api_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            postcard_id: $api_result.response.result.id,
            expected_delivery_date: $api_result.response.result.expected_delivery_date,
            url: $api_result.response.result.url,
            to: $api_result.response.result.to,
            status: $api_result.response.result.status
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Lob API key. Please check your LOB_API_KEY environment variable."
        }
      }
      elseif ($api_result.response.status == 422) {
        var $error_message {
          value = "Validation error: " ~ ($api_result.response.result.error|json_encode)
        }
        throw {
          name = "ValidationError"
          value = $error_message
        }
      }
      else {
        var $error_message {
          value = "Lob API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
        throw {
          name = "APIError"
          value = $error_message
        }
      }
    }
  }
  
  response = $result
}
