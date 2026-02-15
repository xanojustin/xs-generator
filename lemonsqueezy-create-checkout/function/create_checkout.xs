function "create_checkout" {
  description = "Create a LemonSqueezy checkout session for selling products"
  input {
    text store_id filters=trim { description = "LemonSqueezy store ID (e.g., 12345)" }
    text variant_id filters=trim { description = "Product variant ID to sell (e.g., 67890)" }
    text customer_email? filters=trim { description = "Customer email address (optional)" }
    text customer_name? filters=trim { description = "Customer name (optional)" }
    text redirect_url? filters=trim { description = "URL to redirect after checkout (optional)" }
    text custom_price? filters=trim { description = "Custom price in cents (optional, for pay-what-you-want)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.LEMONSQUEEZY_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "LEMONSQUEEZY_API_KEY environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.store_id != null && $input.store_id != "") {
      error_type = "inputerror"
      error = "store_id is required"
    }

    precondition ($input.variant_id != null && $input.variant_id != "") {
      error_type = "inputerror"
      error = "variant_id is required"
    }

    // Build the checkout data payload
    var $checkout_data {
      value = {
        store_id: ($input.store_id|to_int),
        variant_id: ($input.variant_id|to_int)
      }
    }

    // Build attributes object
    var $attributes { value = {} }

    // Add customer email if provided
    conditional {
      if ($input.customer_email != null && $input.customer_email != "") {
        var.update $attributes {
          value = $attributes|set:"checkout_data":{ email: $input.customer_email }
        }
      }
    }

    // Add customer name if provided
    conditional {
      if ($input.customer_name != null && $input.customer_name != "") {
        var $existing_data { value = $attributes|get:"checkout_data" }
        conditional {
          if ($existing_data == null) {
            var $existing_data { value = {} }
          }
        }
        var.update $existing_data {
          value = $existing_data|set:"name":$input.customer_name
        }
        var.update $attributes {
          value = $attributes|set:"checkout_data":$existing_data
        }
      }
    }

    // Add redirect URL if provided
    conditional {
      if ($input.redirect_url != null && $input.redirect_url != "") {
        var.update $attributes {
          value = $attributes|set:"product_options":{ redirect_url: $input.redirect_url }
        }
      }
    }

    // Add custom price if provided (for pay-what-you-want)
    conditional {
      if ($input.custom_price != null && $input.custom_price != "") {
        var.update $attributes {
          value = $attributes|set:"checkout_data":{ custom_price: ($input.custom_price|to_int) }
        }
      }
    }

    // Build the final payload
    var $payload {
      value = {
        data: {
          type: "checkouts",
          attributes: $attributes
        }
      }
    }

    // Add relationships if store_id and variant_id are provided
    var.update $payload {
      value = $payload|set:"data":($payload|get:"data")|set:"relationships":{
        store: { data: { type: "stores", id: ($input.store_id|to_int) } },
        variant: { data: { type: "variants", id: ($input.variant_id|to_int) } }
      }
    }

    // Make the API request to LemonSqueezy
    api.request {
      url = "https://api.lemonsqueezy.com/v1/checkouts"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/vnd.api+json",
        "Accept: application/vnd.api+json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $checkout_id { value = null }
    var $checkout_url { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $expires_at { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $data { value = $response_body|get:"data" }
        var $attributes { value = $data|get:"attributes" }
        
        var $success { value = true }
        var $checkout_id { value = $data|get:"id" }
        var $checkout_url { value = $attributes|get:"url" }
        var $status { value = $attributes|get:"status" }
        var $expires_at { value = $attributes|get:"expires_at" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "LemonSqueezy API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        
        // Try to extract detailed error message
        conditional {
          if ($api_result.response.result != null) {
            var $errors { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($errors != null && ($errors|count) > 0) {
                var $first_error { value = $errors|first }
                var $error_detail { value = $first_error|get:"detail" }
                conditional {
                  if ($error_detail != null) {
                    var $error_message { value = $error_detail }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    checkout_id: $checkout_id,
    checkout_url: $checkout_url,
    status: $status,
    expires_at: $expires_at,
    error: $error_message
  }
}
