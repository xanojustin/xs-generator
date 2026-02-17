function "create_trello_card" {
  description = "Creates a new card on a Trello board using the Trello REST API"
  
  input {
    text list_id
    text card_name
    text card_description?=""
    text card_due_date?=""
    text[] card_labels
  }
  
  stack {
    // Validate environment variables are present
    precondition ($env.trello_api_key != "" && $env.trello_api_key != null) {
      error_type = "standard"
      error = "Missing required environment variable: trello_api_key"
    }
    
    precondition ($env.trello_api_token != "" && $env.trello_api_token != null) {
      error_type = "standard"
      error = "Missing required environment variable: trello_api_token"
    }
    
    // Build the API URL with authentication params
    var $base_url {
      value = "https://api.trello.com/1/cards"
    }
    
    // Prepare the request payload
    var $payload {
      value = {
        idList: $input.list_id,
        name: $input.card_name,
        desc: $input.card_description,
        key: $env.trello_api_key,
        token: $env.trello_api_token
      }
    }
    
    // Add optional due date if provided
    conditional {
      if ($input.card_due_date != "" && $input.card_due_date != null) {
        var $payload_with_due {
          value = $payload|set:"due":$input.card_due_date
        }
        var $payload {
          value = $payload_with_due
        }
      }
    }
    
    // Add optional labels if provided
    conditional {
      if (($input.card_labels|count) > 0) {
        var $labels_string {
          value = $input.card_labels|join:","
        }
        var $payload_with_labels {
          value = $payload|set:"idLabels":$labels_string
        }
        var $payload {
          value = $payload_with_labels
        }
      }
    }
    
    // Make the API request to Trello
    api.request {
      url = $base_url
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json"]
    } as $trello_response
    
    // Check if the request was successful
    precondition ($trello_response.response.status == 200 || $trello_response.response.status == 201) {
      error_type = "standard"
      error = "Trello API request failed: " ~ ($trello_response.response.status|to_text)
    }
    
    // Extract the card data from the response
    var $card_data {
      value = $trello_response.response.result
    }
    
    // Log success
    debug.log {
      value = "Trello card created successfully: " ~ ($card_data|get:"shortUrl")
    }
  }
  
  response = {
    success: true,
    card_id: $card_data|get:"id",
    card_url: $card_data|get:"shortUrl",
    card_name: $card_data|get:"name",
    board_id: $card_data|get:"idBoard",
    list_id: $card_data|get:"idList"
  }
}
