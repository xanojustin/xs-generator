function "list_ngrok_tunnels" {
  description = "List all active ngrok tunnels using the ngrok API"
  input {}
  stack {
    // Make request to ngrok API to list tunnels
    api.request {
      url = "https://api.ngrok.com/tunnels"
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $env.ngrok_api_key,
        "Content-Type: application/json",
        "Ngrok-Version: 2"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $tunnels_data { value = $api_result.response.result }
      }
      else {
        throw {
          name = "NgrokAPIError"
          value = "Ngrok API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }

    // Format the response for easier consumption
    var $formatted_response {
      value = {
        tunnel_count: $tunnels_data.tunnels|count,
        tunnels: $tunnels_data.tunnels
      }
    }
  }
  response = $formatted_response
}
