function "bitly_shorten" {
  description = "Shorten a URL using the Bitly API"
  input {
    text long_url { description = "The long URL to shorten (must include http:// or https://)" }
    text domain { description = "Optional: Custom domain (default: bit.ly)" }
    text title { description = "Optional: Title for the shortened link" }
  }
  stack {
    var $payload {
      value = {
        long_url: $input.long_url
      }
    }

    conditional {
      if (($input.domain != null) && (($input.domain|strlen) > 0)) {
        var $payload {
          value = $payload.value ~ { domain: $input.domain }
        }
      }
    }

    conditional {
      if (($input.title != null) && (($input.title|strlen) > 0)) {
        var $payload {
          value = $payload.value ~ { title: $input.title }
        }
      }
    }

    api.request {
      url = "https://api-ssl.bitly.com/v4/shorten"
      method = "POST"
      params = $payload.value
      headers = [
        "Authorization: Bearer " ~ $env.bitly_api_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if (($api_result.response.status >= 200) && ($api_result.response.status < 300)) {
        var $shortened { value = $api_result.response.result }
      }
      else {
        throw {
          name = "BitlyAPIError"
          value = "Bitly API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $shortened
}
