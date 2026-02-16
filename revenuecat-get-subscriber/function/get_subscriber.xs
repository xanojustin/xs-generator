function "get_subscriber" {
  description = "Fetch subscriber information from RevenueCat API"
  input {
    text app_user_id filters=trim
  }
  stack {
    // Validate input
    precondition ($input.app_user_id != null && $input.app_user_id != "") {
      error_type = "inputerror"
      error = "app_user_id is required"
    }

    // Build the API URL
    var $api_url {
      value = "https://api.revenuecat.com/v1/subscribers/" ~ $input.app_user_id
    }

    // Make the API request to RevenueCat
    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.revenuecat_api_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "RevenueCat API error: " ~ ($api_result.response.status|to_text)
    }

    // Extract subscriber data
    var $subscriber {
      value = $api_result.response.result.subscriber
    }

    // Build response
    var $response_data {
      value = {
        app_user_id: $input.app_user_id,
        original_app_user_id: $subscriber.original_app_user_id,
        first_seen: $subscriber.first_seen,
        last_seen: $subscriber.last_seen,
        entitlements: $subscriber.entitlements,
        subscriptions: $subscriber.subscriptions,
        non_subscriptions: $subscriber.non_subscriptions
      }
    }
  }
  response = $response_data
}
