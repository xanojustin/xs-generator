function "get_form_responses" {
  description = "Fetch responses from a Typeform form"
  input {
    text form_id filters=trim { description = "Typeform form ID (found in form URL or settings)" }
    text page_size?="10" filters=trim { description = "Number of responses to fetch (default: 10, max: 1000)" }
    text since? filters=trim { description = "Fetch responses submitted after this date (ISO 8601 format, optional)" }
    text until? filters=trim { description = "Fetch responses submitted before this date (ISO 8601 format, optional)" }
    text completed? filters=trim { description = "Filter by completion status: 'true' for completed only, 'false' for partial (optional)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.TYPEFORM_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "TYPEFORM_API_KEY environment variable not configured"
    }

    // Validate form_id is provided
    precondition ($input.form_id != null && $input.form_id != "") {
      error_type = "inputerror"
      error = "Form ID is required"
    }

    // Build query parameters
    var $query_params {
      value = {
        page_size: $input.page_size
      }
    }

    // Add since parameter if provided
    conditional {
      if ($input.since != null && $input.since != "") {
        var.update $query_params {
          value = $query_params|set:"since":$input.since
        }
      }
    }

    // Add until parameter if provided
    conditional {
      if ($input.until != null && $input.until != "") {
        var.update $query_params {
          value = $query_params|set:"until":$input.until
        }
      }
    }

    // Add completed filter if provided
    conditional {
      if ($input.completed != null && $input.completed != "") {
        var.update $query_params {
          value = $query_params|set:"completed":$input.completed
        }
      }
    }

    // Build the API URL
    var $api_url {
      value = "https://api.typeform.com/forms/" ~ $input.form_id ~ "/responses"
    }

    // Send request to Typeform API
    api.request {
      url = $api_url
      method = "GET"
      params = $query_params
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $total_items { value = 0 }
    var $responses { value = [] }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $total_items_raw { value = $response_body|get:"total_items" }
        var $total_items {
          value = ($total_items_raw ?? 0)
        }
        var $items_raw { value = $response_body|get:"items" }
        var $responses {
          value = ($items_raw ?? [])
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Typeform API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj|get:"message"
                }
              }
            }
            // Try alternative error format
            conditional {
              if ($api_result.response.result|get:"description" != null) {
                var $error_message {
                  value = $api_result.response.result|get:"description"
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
    total_items: $total_items,
    responses: $responses,
    error: $error_message
  }
}
