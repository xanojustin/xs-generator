function "lookup_ip_info" {
  description = "Look up detailed IP intelligence data using ipinfo.io API"
  input {
    text ip? filters=trim { description = "IP address to lookup (optional, uses request IP if not provided)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.IPINFO_API_KEY }

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

    // Build the API URL - ipinfo.io uses token-based auth in query param
    var $base_url {
      value = "https://ipinfo.io/" ~ $target_ip ~ "/json"
    }

    // Add API token to URL if available
    conditional {
      if ($api_key != null && $api_key != "") {
        var $base_url {
          value = $base_url ~ "?token=" ~ $api_key
        }
      }
    }

    // Send the request to ipinfo.io
    api.request {
      url = $base_url
      method = "GET"
      headers = [
        "Accept: application/json"
      ]
      timeout = 15
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $error_message { value = null }
    var $ip_data { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $success { value = true }
        var $ip_data { value = $api_result.response.result }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "ipinfo.io API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_detail { value = $api_result.response.result|get:"error"|get:"message" }
            conditional {
              if ($error_detail != null) {
                var $error_message {
                  value = $error_detail
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
    data: $ip_data,
    error: $error_message
  }
}