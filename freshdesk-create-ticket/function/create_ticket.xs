function "create_ticket" {
  description = "Create a support ticket in Freshdesk"
  input {
    text subject filters=trim { description = "Ticket subject line" }
    text description filters=trim { description = "Ticket description/body" }
    text email filters=trim { description = "Requester email address" }
    text name?="Xano User" filters=trim { description = "Requester name (optional)" }
    int priority?=1 { description = "Priority: 1=Low, 2=Medium, 3=High, 4=Urgent (default: 1)" }
    int status?=2 { description = "Status: 2=Open, 3=Pending, 4=Resolved, 5=Closed (default: 2)" }
    text source?="2" filters=trim { description = "Source: 1=Email, 2=Portal, 3=Phone, 7=Chat, 9=Feedback Widget (default: 2)" }
    text[]? tags { description = "Array of tags to apply to the ticket (optional)" }
  }

  stack {
    // Get environment variables
    var $api_key { value = $env.FRESHDESK_API_KEY }
    var $domain { value = $env.FRESHDESK_DOMAIN }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "FRESHDESK_API_KEY environment variable not configured"
    }

    // Validate domain is configured
    precondition ($domain != null && $domain != "") {
      error_type = "standard"
      error = "FRESHDESK_DOMAIN environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    precondition ($input.description != null && $input.description != "") {
      error_type = "inputerror"
      error = "Description is required"
    }

    precondition ($input.email != null && $input.email != "") {
      error_type = "inputerror"
      error = "Email is required"
    }

    // Build the request payload
    var $payload {
      value = {
        subject: $input.subject,
        description: $input.description,
        email: $input.email,
        name: $input.name,
        priority: $input.priority,
        status: $input.status,
        source: $input.source|to_int
      }
    }

    // Add tags if provided
    conditional {
      if ($input.tags != null && ($input.tags|count) > 0) {
        var.update $payload {
          value = $payload|set:"tags":$input.tags
        }
      }
    }

    // Construct the API URL
    var $api_url { value = "https://" ~ $domain ~ ".freshdesk.com/api/v2/tickets" }

    // Send the request to Freshdesk
    // Freshdesk uses Basic Auth: API key as username, X as password
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($api_key ~ ":X"|base64_encode)
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $ticket_id { value = null }
    var $ticket_url { value = null }
    var $error_message { value = null }
    var $created_at { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $ticket_id { value = $response_body|get:"id" }
        var $created_at { value = $response_body|get:"created_at" }
        
        // Build ticket URL
        conditional {
          if ($ticket_id != null) {
            var $ticket_url {
              value = "https://" ~ $domain ~ ".freshdesk.com/a/tickets/" ~ ($ticket_id|to_text)
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Freshdesk API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = ($error_obj|json_encode)
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
    created_at: $created_at,
    error: $error_message
  }
}
