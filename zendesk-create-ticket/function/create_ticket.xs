function "create_ticket" {
  description = "Create a support ticket in Zendesk"
  input {
    text subject filters=trim { description = "Ticket subject line" }
    text body filters=trim { description = "Ticket body/description" }
    text priority?="normal" filters=trim { description = "Priority: urgent, high, normal, low (default: normal)" }
    text requester_name? filters=trim { description = "Name of the requester (optional)" }
    text requester_email filters=trim { description = "Email of the requester" }
    text tags? filters=trim { description = "Comma-separated list of tags (optional)" }
  }

  stack {
    // Get API credentials from environment
    var $subdomain { value = $env.ZENDESK_SUBDOMAIN }
    var $api_token { value = $env.ZENDESK_API_TOKEN }
    var $api_email { value = $env.ZENDESK_API_EMAIL }

    // Validate environment variables
    precondition ($subdomain != null && $subdomain != "") {
      error_type = "standard"
      error = "ZENDESK_SUBDOMAIN environment variable not configured"
    }

    precondition ($api_token != null && $api_token != "") {
      error_type = "standard"
      error = "ZENDESK_API_TOKEN environment variable not configured"
    }

    precondition ($api_email != null && $api_email != "") {
      error_type = "standard"
      error = "ZENDESK_API_EMAIL environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    precondition ($input.body != null && $input.body != "") {
      error_type = "inputerror"
      error = "Body is required"
    }

    precondition ($input.requester_email != null && $input.requester_email != "") {
      error_type = "inputerror"
      error = "Requester email is required"
    }

    // Build the ticket payload
    var $ticket_data {
      value = {
        subject: $input.subject,
        comment: { body: $input.body },
        priority: $input.priority,
        requester: { email: $input.requester_email }
      }
    }

    // Add requester name if provided
    conditional {
      if ($input.requester_name != null && $input.requester_name != "") {
        var $requester_obj { value = $ticket_data|get:"requester" }
        var $updated_requester { value = $requester_obj|set:"name":$input.requester_name }
        var.update $ticket_data {
          value = $ticket_data|set:"requester":$updated_requester
        }
      }
    }

    // Parse and add tags if provided
    conditional {
      if ($input.tags != null && $input.tags != "") {
        var $tags_array {
          value = $input.tags|split:","
        }
        var.update $ticket_data {
          value = $ticket_data|set:"tags":$tags_array
        }
      }
    }

    var $payload {
      value = { ticket: $ticket_data }
    }

    // Build the API URL
    var $api_url {
      value = "https://" ~ $subdomain ~ ".zendesk.com/api/v2/tickets.json"
    }

    // Build the authentication header (Basic auth with email/token:api_token)
    var $auth_string {
      value = $api_email ~ "/token:" ~ $api_token
    }

    // Send the request to Zendesk
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($auth_string|base64_encode)
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $ticket_id { value = null }
    var $ticket_url { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $created_at { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $ticket_obj { value = $response_body|get:"ticket" }
        conditional {
          if ($ticket_obj != null) {
            var $success { value = true }
            var $ticket_id { value = $ticket_obj|get:"id" }
            var $ticket_url { value = $ticket_obj|get:"url" }
            var $status { value = $ticket_obj|get:"status" }
            var $created_at { value = $ticket_obj|get:"created_at" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Zendesk API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_title { value = $error_obj|get:"title" }
                var $error_details { value = $error_obj|get:"message" }
                var $error_message {
                  value = $error_title ~ " - " ~ $error_details
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
    ticket_id: $ticket_id,
    ticket_url: $ticket_url,
    status: $status,
    created_at: $created_at,
    error: $error_message
  }
}
