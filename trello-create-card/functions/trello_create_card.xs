function "trello_create_card" {
  description = "Create a new card in a Trello list"
  input {
    text list_id filters=trim
    text card_name filters=trim
    text card_description? filters=trim
    text due_date? filters=trim
    text labels? filters=trim
  }
  stack {
    precondition (($input.list_id|is_empty) == false) {
      error_type = "inputerror"
      error = "Trello list ID is required"
    }

    precondition (($input.card_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Card name is required"
    }

    var $request_body {
      value = {
        key: $env.trello_api_key,
        token: $env.trello_api_token,
        idList: $input.list_id,
        name: $input.card_name
      }
    }

    // Add optional description if provided
    precondition (($input.card_description|is_empty) == false) {
      var $body_with_desc {
        value = {
          key: $env.trello_api_key,
          token: $env.trello_api_token,
          idList: $input.list_id,
          name: $input.card_name,
          desc: $input.card_description
        }
      }
    } alternative {
      var $body_with_desc {
        value = $request_body
      }
    }

    // Add optional due date if provided
    precondition (($input.due_date|is_empty) == false) {
      var $body_with_due {
        value = {
          key: $env.trello_api_key,
          token: $env.trello_api_token,
          idList: $input.list_id,
          name: $input.card_name,
          desc: ($input.card_description|is_empty) == false ? $input.card_description : "",
          due: $input.due_date
        }
      }
    } alternative {
      var $body_with_due {
        value = $body_with_desc
      }
    }

    // Add optional labels if provided (comma-separated)
    precondition (($input.labels|is_empty) == false) {
      var $final_body {
        value = {
          key: $env.trello_api_key,
          token: $env.trello_api_token,
          idList: $input.list_id,
          name: $input.card_name,
          desc: ($input.card_description|is_empty) == false ? $input.card_description : "",
          due: ($input.due_date|is_empty) == false ? $input.due_date : "",
          idLabels: $input.labels
        }
      }
    } alternative {
      var $final_body {
        value = $body_with_due
      }
    }

    api.request {
      url = "https://api.trello.com/1/cards"
      method = "POST"
      headers = [
        "Content-Type: application/json"
      ]
      params = $final_body
    } as $api_result

    var $response_status {
      value = $api_result.response.status
    }

    precondition ($response_status == 200) {
      error_type = "standard"
      error = "Failed to create Trello card: " ~ ($api_result.response.body|json)
    }

    var $card_data {
      value = $api_result.response.body
    }
  }
  response = {
    success: true,
    card_id: $card_data.id,
    card_url: $card_data.shortUrl,
    card_name: $card_data.name,
    list_id: $card_data.idList,
    board_id: $card_data.idBoard,
    created_at: $card_data.dateLastActivity
  }
}
