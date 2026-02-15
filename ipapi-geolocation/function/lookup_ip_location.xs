function "lookup_ip_location" {
  description = "Look up geolocation data for an IP address using ipapi.co"
  input {
    text ip? filters=trim { description = "IP address to lookup (optional, uses request IP if not provided)" }
    text fields? filters=trim { description = "Comma-separated list of fields to return (optional, e.g., 'country,city,lat,lon')" }
  }

  stack {
    // Get API key from environment (free tier doesn't require key, but paid does)
    var $api_key { value = $env.IPAPI_API_KEY }

    // Determine the IP to lookup
    var $target_ip {
      value = $input.ip
    }

    // If no IP provided, use the remote IP from the request
    conditional {
      if ($target_ip == null || $target_ip == "") {
        var $target_ip {
          value = $env.$remote_ip
        }
      }
    }

    // Validate we have an IP address
    precondition ($target_ip != null && $target_ip != "") {
      error_type = "inputerror"
      error = "No IP address provided and could not determine remote IP"
    }

    // Build the API URL
    var $base_url {
      value = "https://ipapi.co/" ~ $target_ip ~ "/json/"
    }

    // Build headers array
    var $headers {
      value = [
        "Content-Type: application/json"
      ]
    }

    // Add API key to headers if available
    conditional {
      if ($api_key != null && $api_key != "") {
        var $headers {
          value = $headers|merge:["Authorization: Bearer " ~ $api_key]
        }
      }
    }

    // Send the request to ipapi.co
    api.request {
      url = $base_url
      method = "GET"
      headers = $headers
      timeout = 15
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $error_message { value = null }
    var $location_data { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $success { value = true }
        var $location_data { value = $api_result.response.result }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "ipapi.co API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_reason { value = $api_result.response.result|get:"reason" }
            conditional {
              if ($error_reason != null) {
                var $error_message {
                  value = $error_reason
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
    ip: $target_ip,
    location: $location_data,
    error: $error_message
  }
}
