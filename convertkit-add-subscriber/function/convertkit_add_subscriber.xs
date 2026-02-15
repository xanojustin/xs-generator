function "convertkit_add_subscriber" {
  description = "Add a subscriber to a ConvertKit form via the ConvertKit API"
  input {
    email email filters=trim|lower { description = "Subscriber email address" }
    text first_name filters=trim { description = "Subscriber first name" }
    int form_id { description = "ConvertKit form ID to subscribe to" }
  }
  stack {
    // Validate required environment variables
    precondition ($env.CONVERTKIT_API_KEY != null && $env.CONVERTKIT_API_KEY != "") {
      error_type = "standard"
      error = "CONVERTKIT_API_KEY environment variable is required"
    }

    // Build the request payload
    var $payload {
      value = {
        email: $input.email,
        api_key: $env.CONVERTKIT_API_KEY
      }
    }

    // Add optional first_name if provided
    conditional {
      if ($input.first_name != null && $input.first_name != "") {
        var.update $payload {
          value = $payload|set:"first_name":$input.first_name
        }
      }
    }

    // Build the API URL with the form_id
    var $api_url {
      value = "https://api.convertkit.com/v3/forms/" ~ ($input.form_id|to_text) ~ "/subscribe"
    }

    // Make the API request to ConvertKit
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Accept: application/json"
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        // Extract subscriber data from response
        var $subscriber {
          value = $api_result.response.result.subscription
        }

        var $result_data {
          value = {
            success: true,
            subscriber: $subscriber
          }
        }
      }
      else {
        // Handle API errors
        var $error_message {
          value = ($api_result.response.result.message ?? ($api_result.response.result.error ?? "Unknown ConvertKit API error"))
        }

        throw {
          name = "ConvertKitAPIError"
          value = {
            success: false,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result_data
}
