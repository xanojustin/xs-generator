function "create_card" {
  description = "Create a new card on a Trello board"
  input {
    text name filters=trim { description = "Name/title of the card (required)" }
    text description? filters=trim { description = "Description/body of the card (optional)" }
    text list_id filters=trim { description = "Trello list ID where the card should be created (required)" }
    text due_date? filters=trim { description = "Due date in ISO format (optional, e.g., 2026-02-20T17:00:00.000Z)" }
    text label_ids? filters=trim { description = "Comma-separated list of label IDs to attach (optional)" }
    text member_ids? filters=trim { description = "Comma-separated list of member IDs to assign (optional)" }
  }

  stack {
    // Get credentials from environment
    var $api_key { value = $env.TRELLO_API_KEY }
    var $token { value = $env.TRELLO_TOKEN }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "TRELLO_API_KEY environment variable not configured"
    }

    // Validate token is configured
    precondition ($token != null && $token != "") {
      error_type = "standard"
      error = "TRELLO_TOKEN environment variable not configured"
    }

    // Validate name is provided
    precondition ($input.name != null && $input.name != "") {
      error_type = "inputerror"
      error = "Card name is required"
    }

    // Validate list_id is provided
    precondition ($input.list_id != null && $input.list_id != "") {
      error_type = "inputerror"
      error = "List ID is required"
    }

    // Build the request payload
    var $payload {
      value = {
        name: $input.name,
        idList: $input.list_id,
        key: $api_key,
        token: $token
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != null && $input.description != "") {
        var.update $payload {
          value = $payload|set:"desc":$input.description
        }
      }
    }

    // Add due date if provided
    conditional {
      if ($input.due_date != null && $input.due_date != "") {
        var.update $payload {
          value = $payload|set:"due":$input.due_date
        }
      }
    }

    // Send the request to Trello
    api.request {
      url = "https://api.trello.com/1/cards"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $card_id { value = null }
    var $card_url { value = null }
    var $card_name { value = null }
    var $error_message { value = null }
    var $board_id { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $card_id { value = $response_body|get:"id" }
        var $card_url { value = $response_body|get:"shortUrl" }
        var $card_name { value = $response_body|get:"name" }
        var $board_id { value = $response_body|get:"idBoard" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Trello API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_text { value = $api_result.response.result|get:"message" }
            conditional {
              if ($error_text != null) {
                var $error_message {
                  value = $error_text
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
    card_id: $card_id,
    card_url: $card_url,
    card_name: $card_name,
    board_id: $board_id,
    error: $error_message
  }
}
