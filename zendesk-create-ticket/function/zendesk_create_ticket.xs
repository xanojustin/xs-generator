function "zendesk_create_ticket" {
  description = "Create a support ticket in Zendesk"
  input {
    text subject { description = "Subject line of the ticket" }
    text body { description = "Body/description of the ticket" }
    text requester_email { description = "Email address of the ticket requester" }
    text requester_name { description = "Name of the ticket requester" }
    text priority { description = "Ticket priority: urgent, high, normal, or low" }
    text[] tags { description = "Optional tags to apply to the ticket" }
  }
  stack {
    // Build the ticket payload for Zendesk API
    var $ticket_data {
      value = {
        ticket: {
          subject: $input.subject,
          comment: {
            body: $input.body
          },
          requester: {
            name: $input.requester_name,
            email: $input.requester_email
          },
          priority: $input.priority
        }
      }
    }

    // Add tags if provided
    conditional {
      if (($input.tags|count) > 0) {
        var $ticket_with_tags {
          value = $ticket_data.ticket
        }
        // Update the object with tags
        var $updated_ticket {
          value = $ticket_with_tags ~ { tags: $input.tags }
        }
        var $ticket_data {
          value = { ticket: $updated_ticket }
        }
      }
    }

    // Construct Zendesk API URL
    var $api_url {
      value = "https://" ~ $env.zendesk_subdomain ~ ".zendesk.com/api/v2/tickets.json"
    }

    // Create base64 encoded credentials for Basic Auth
    var $credentials {
      value = $env.zendesk_email ~ "/token:" ~ $env.zendesk_api_token
    }

    // Make the API request to Zendesk
    api.request {
      url = $api_url
      method = "POST"
      params = $ticket_data
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($credentials|base64_encode)
      ]
      timeout = 30
    } as $api_result

    // Handle the response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $ticket { value = $api_result.response.result }
      }
      else {
        throw {
          name = "ZendeskAPIError"
          value = "Zendesk API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $ticket
}
