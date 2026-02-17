function "convertkit_add_subscriber" {
  description = "Add a subscriber to ConvertKit"
  input {
    text email { description = "Subscriber email address" }
    text first_name { description = "Subscriber first name" }
    text tags_json { description = "JSON array of tag IDs as string (e.g., '[123, 456]')" }
  }
  stack {
    var $payload {
      value = {
        email_address: $input.email,
        api_key: $env.convertkit_api_key
      }
    }

    conditional {
      if (($input.first_name|strlen) > 0) {
        var $payload {
          value = $payload ~ {first_name: $input.first_name}
        }
      }
    }

    conditional {
      if (($input.tags_json|strlen) > 0) {
        var $tag_list {
          value = $input.tags_json|json_decode
        }
        var $payload {
          value = $payload ~ {tags: $tag_list}
        }
      }
    }

    api.request {
      url = "https://api.convertkit.com/v3/subscribers"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if (($api_result.response.status >= 200) && ($api_result.response.status < 300)) {
        var $subscriber { value = $api_result.response.result }
      }
      else {
        throw {
          name = "ConvertKitAPIError"
          value = "ConvertKit API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $subscriber
}
