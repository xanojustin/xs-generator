function "plaid_get_balance" {
  description = "Retrieve account balances from Plaid for a connected bank account"
  input {
    text access_token filters=trim
    text plaid_environment?="sandbox" filters=trim|lower
  }
  stack {
    precondition (($input.access_token|is_empty) == false) {
      error_type = "inputerror"
      error = "Plaid access_token is required"
    }

    conditional {
      if ($input.plaid_environment == "production") {
        var $plaid_base_url { value = "https://production.plaid.com" }
      }
      else {
        var $plaid_base_url { value = "https://sandbox.plaid.com" }
      }
    }

    var $request_body {
      value = {
        client_id: $env.plaid_client_id,
        secret: $env.plaid_secret,
        access_token: $input.access_token
      }
    }

    api.request {
      url = $plaid_base_url ~ "/accounts/balance/get"
      method = "POST"
      headers = [
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $plaid_response

    var $response_status {
      value = $plaid_response.response.status
    }

    conditional {
      if ($response_status != 200) {
        var $error_message { value = "Unknown error from Plaid API" }
        
        conditional {
          if (($plaid_response.response.body.error_message|is_empty) == false) {
            var.update $error_message { value = $plaid_response.response.body.error_message }
          }
        }
        
        throw {
          name = "PlaidAPIError"
          value = $error_message
        }
      }
    }

    var $accounts {
      value = $plaid_response.response.body.accounts
    }

    var $item {
      value = $plaid_response.response.body.item
    }

    var $total_balance {
      value = ($accounts|map:$$.balances.current)|sum
    }

    var $account_summary {
      value = $accounts|map:{
        account_id: $$.account_id,
        name: $$.name,
        type: $$.type,
        subtype: $$.subtype,
        mask: $$.mask,
        current_balance: $$.balances.current,
        available_balance: $$.balances.available,
        currency: $$.balances.iso_currency_code
      }
    }
  }
  response = {
    success: true,
    item_id: $item.item_id,
    institution_id: $item.institution_id,
    accounts: $account_summary,
    total_balance: $total_balance,
    account_count: $accounts|count
  }
}
