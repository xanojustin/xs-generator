function "create_webflow_cms_item" {
  input {
    text collection_id
    text item_name
    text slug
    json fields
  }
  stack {
    // Validate required inputs
    precondition ($input.collection_id != null && $input.collection_id != "") {
      error_type = "inputerror"
      error = "collection_id is required"
    }

    precondition ($input.item_name != null && $input.item_name != "") {
      error_type = "inputerror"
      error = "item_name is required"
    }

    // Check for environment variables
    precondition ($env.webflow_api_token != null && $env.webflow_api_token != "") {
      error_type = "standard"
      error = "webflow_api_token environment variable is required"
    }

    // Build the request payload for Webflow API v2
    // Webflow v2 API uses a different structure with fieldData
    var $field_data {
      value = {
        name: $input.item_name,
        slug: $input.slug
      }
    }

    // Merge additional custom fields if provided
    conditional {
      if ($input.fields != null && ($input.fields|count) > 0) {
        var.update $field_data { value = $field_data|merge:$input.fields }
      }
    }

    // Build the complete payload
    var $payload {
      value = {
        fieldData: $field_data
      }
    }

    // Make the API request to Webflow
    api.request {
      url = "https://api.webflow.com/v2/collections/" ~ $input.collection_id ~ "/items"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.webflow_api_token
      ]
      timeout = 30
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        // Success - extract the created item data
        var $created_item { value = $api_result.response.result }
        var $response_data {
          value = {
            success: true,
            item_id: $created_item|get:"id":"",
            item_name: $input.item_name,
            collection_id: $input.collection_id,
            created_at: $created_item|get:"createdOn":"",
            data: $created_item
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - validation error
        throw {
          name = "WebflowValidationError"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized
        throw {
          name = "WebflowAuthError"
          value = "Authentication failed - check your webflow_api_token"
        }
      }
      elseif ($api_result.response.status == 404) {
        // Not found - collection doesn't exist
        throw {
          name = "WebflowNotFoundError"
          value = "Collection not found: " ~ $input.collection_id
        }
      }
      else {
        // Other errors
        throw {
          name = "WebflowAPIError"
          value = "Webflow API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $response_data
}
