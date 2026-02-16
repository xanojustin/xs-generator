function "create_shipment" {
  description = "Create a shipping label using EasyPost API"
  input {
    text to_address_name filters=trim { description = "Recipient full name" }
    text to_address_street1 filters=trim { description = "Recipient street address line 1" }
    text to_address_street2? filters=trim { description = "Recipient street address line 2 (optional)" }
    text to_address_city filters=trim { description = "Recipient city" }
    text to_address_state filters=trim { description = "Recipient state/province (2-letter code)" }
    text to_address_zip filters=trim { description = "Recipient ZIP/postal code" }
    text to_address_country?="US" filters=trim { description = "Recipient country code (default: US)" }
    text to_address_phone? filters=trim { description = "Recipient phone number (optional)" }
    text from_address_id filters=trim { description = "EasyPost Address ID for sender (or provide from_address fields)" }
    text from_address_name? filters=trim { description = "Sender full name (if not using from_address_id)" }
    text from_address_street1? filters=trim { description = "Sender street address line 1 (if not using from_address_id)" }
    text from_address_city? filters=trim { description = "Sender city (if not using from_address_id)" }
    text from_address_state? filters=trim { description = "Sender state (if not using from_address_id)" }
    text from_address_zip? filters=trim { description = "Sender ZIP (if not using from_address_id)" }
    text parcel_weight filters=trim { description = "Package weight in ounces" }
    text parcel_length? filters=trim { description = "Package length in inches (optional)" }
    text parcel_width? filters=trim { description = "Package width in inches (optional)" }
    text parcel_height? filters=trim { description = "Package height in inches (optional)" }
    text carrier? filters=trim { description = "Preferred carrier (e.g., USPS, UPS, FedEx) - optional" }
    text service? filters=trim { description = "Service level (e.g., Priority, Ground) - optional" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.EASYPOST_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "EASYPOST_API_KEY environment variable not configured"
    }

    // Validate required recipient fields
    precondition ($input.to_address_name != null && $input.to_address_name != "") {
      error_type = "inputerror"
      error = "Recipient name (to_address_name) is required"
    }

    precondition ($input.to_address_street1 != null && $input.to_address_street1 != "") {
      error_type = "inputerror"
      error = "Recipient street address (to_address_street1) is required"
    }

    precondition ($input.to_address_city != null && $input.to_address_city != "") {
      error_type = "inputerror"
      error = "Recipient city (to_address_city) is required"
    }

    precondition ($input.to_address_state != null && $input.to_address_state != "") {
      error_type = "inputerror"
      error = "Recipient state (to_address_state) is required"
    }

    precondition ($input.to_address_zip != null && $input.to_address_zip != "") {
      error_type = "inputerror"
      error = "Recipient ZIP code (to_address_zip) is required"
    }

    // Validate parcel weight
    precondition ($input.parcel_weight != null && $input.parcel_weight != "") {
      error_type = "inputerror"
      error = "Parcel weight is required"
    }

    // Check if from_address_id is provided
    var $has_address_id { value = ($input.from_address_id != null && $input.from_address_id != "") }
    
    // Check if complete from address is provided
    var $has_from_name { value = ($input.from_address_name != null && $input.from_address_name != "") }
    var $has_from_street { value = ($input.from_address_street1 != null && $input.from_address_street1 != "") }
    var $has_from_city { value = ($input.from_address_city != null && $input.from_address_city != "") }
    var $has_from_state { value = ($input.from_address_state != null && $input.from_address_state != "") }
    var $has_from_zip { value = ($input.from_address_zip != null && $input.from_address_zip != "") }
    var $has_full_address {
      value = ($has_from_name && $has_from_street && $has_from_city && $has_from_state && $has_from_zip)
    }
    
    // Validate sender info - use conditional to check either/or
    var $sender_valid { value = false }
    conditional {
      if ($has_address_id) {
        var $sender_valid { value = true }
      }
      elseif ($has_full_address) {
        var $sender_valid { value = true }
      }
    }
    
    precondition ($sender_valid) {
      error_type = "inputerror"
      error = "Either from_address_id or complete from_address fields are required"
    }

    // Build to_address object
    var $to_address {
      value = {
        name: $input.to_address_name,
        street1: $input.to_address_street1,
        city: $input.to_address_city,
        state: $input.to_address_state,
        zip: $input.to_address_zip,
        country: $input.to_address_country
      }
    }

    // Add optional to_address fields
    conditional {
      if ($input.to_address_street2 != null && $input.to_address_street2 != "") {
        var.update $to_address {
          value = $to_address|set:"street2":$input.to_address_street2
        }
      }
    }

    conditional {
      if ($input.to_address_phone != null && $input.to_address_phone != "") {
        var.update $to_address {
          value = $to_address|set:"phone":$input.to_address_phone
        }
      }
    }

    // Build from_address (either ID or object)
    var $from_address { value = null }
    conditional {
      if ($has_address_id) {
        var $from_address {
          value = { id: $input.from_address_id }
        }
      }
      elseif ($has_full_address) {
        var $from_address_obj {
          value = {
            name: $input.from_address_name,
            street1: $input.from_address_street1,
            city: $input.from_address_city,
            state: $input.from_address_state,
            zip: $input.from_address_zip,
            country: "US"
          }
        }
        var $from_address {
          value = $from_address_obj
        }
      }
    }

    // Build parcel object
    var $parcel {
      value = {
        weight: $input.parcel_weight
      }
    }

    conditional {
      if ($input.parcel_length != null && $input.parcel_length != "") {
        var.update $parcel {
          value = $parcel|set:"length":$input.parcel_length
        }
      }
    }

    conditional {
      if ($input.parcel_width != null && $input.parcel_width != "") {
        var.update $parcel {
          value = $parcel|set:"width":$input.parcel_width
        }
      }
    }

    conditional {
      if ($input.parcel_height != null && $input.parcel_height != "") {
        var.update $parcel {
          value = $parcel|set:"height":$input.parcel_height
        }
      }
    }

    // Build shipment payload
    var $payload {
      value = {
        shipment: {
          to_address: $to_address,
          from_address: $from_address,
          parcel: $parcel
        }
      }
    }

    // Send the request to EasyPost
    api.request {
      url = "https://api.easypost.com/v2/shipments"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $shipment_id { value = null }
    var $tracking_code { value = null }
    var $tracking_url { value = null }
    var $label_url { value = null }
    var $rate_id { value = null }
    var $carrier { value = null }
    var $service { value = null }
    var $shipping_cost { value = null }
    var $error_message { value = null }
    var $rates { value = [] }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201 || $api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $shipment_id { value = $response_body|get:"id" }
        var $tracking_code { value = $response_body|get:"tracking_code" }
        var $tracking_url { value = $response_body|get:"tracker"|get:"public_url" }
        var $rates { value = $response_body|get:"rates" }

        // Get the first rate if available
        conditional {
          if ($rates != null && ($rates|length) > 0) {
            var $first_rate { value = $rates|first }
            var $rate_id { value = $first_rate|get:"id" }
            var $carrier { value = $first_rate|get:"carrier" }
            var $service { value = $first_rate|get:"service" }
            var $shipping_cost { value = $first_rate|get:"rate" }
          }
        }

        // Get postage label URL if available
        var $postage_label { value = $response_body|get:"postage_label" }
        conditional {
          if ($postage_label != null) {
            var $label_url { value = $postage_label|get:"label_url" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_obj { value = $error_body|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj|get:"message"
                }
              }
              else {
                var $error_message {
                  value = "EasyPost API error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "EasyPost API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    shipment_id: $shipment_id,
    tracking_code: $tracking_code,
    tracking_url: $tracking_url,
    label_url: $label_url,
    rate_id: $rate_id,
    carrier: $carrier,
    service: $service,
    shipping_cost: $shipping_cost,
    rates_available: $rates,
    error: $error_message
  }
}
