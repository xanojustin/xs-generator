function "create_droplet" {
  input {
    text name
    text region
    text size
    text image
  }
  stack {
    // Validate required inputs
    precondition ($input.name != null && $input.name != "") {
      error_type = "inputerror"
      error = "Droplet name is required"
    }

    precondition ($input.region != null && $input.region != "") {
      error_type = "inputerror"
      error = "Region is required (e.g., nyc3, sfo3, ams3)"
    }

    precondition ($input.size != null && $input.size != "") {
      error_type = "inputerror"
      error = "Size slug is required (e.g., s-1vcpu-1gb)"
    }

    precondition ($input.image != null && $input.image != "") {
      error_type = "inputerror"
      error = "Image slug is required (e.g., ubuntu-24-04-x64)"
    }

    precondition ($env.digitalocean_api_token != null && $env.digitalocean_api_token != "") {
      error_type = "standard"
      error = "DigitalOcean API token is required. Set the digitalocean_api_token environment variable."
    }

    // Build the request payload
    var $payload {
      value = {
        name: $input.name,
        region: $input.region,
        size: $input.size,
        image: $input.image
      }
    }

    // Call DigitalOcean API to create droplet
    api.request {
      url = "https://api.digitalocean.com/v2/droplets"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.digitalocean_api_token
      ]
      timeout = 60
    } as $api_result

    // Check if the request was successful
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $droplet { value = $api_result.response.result.droplet }
        var $result {
          value = {
            success: true,
            message: "Droplet created successfully",
            droplet: $droplet
          }
        }
      }
      else {
        var $error_message { value = "DigitalOcean API error: " ~ ($api_result.response.status|to_text) }
        
        conditional {
          if ($api_result.response.result.message != null) {
            var $error_message { value = $error_message ~ " - " ~ $api_result.response.result.message }
          }
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
