function "exchange_and_get_balance" {
  input {
    text public_token
  }

  stack {
    // Validate required inputs
    precondition ($input.public_token != "" && $input.public_token != null) {
      error_type = "inputerror"
      error = "public_token is required"
    }

    // Determine the base URL based on environment
    var $base_url {
      value = "https://production.plaid.com"
    }

    conditional {
      if ($env.PLAID_ENV == "sandbox") {
        var.update $base_url { value = "https://sandbox.plaid.com" }
      }
      elseif ($env.PLAID_ENV == "development") {
        var.update $base_url { value = "https://development.plaid.com" }
      }
    }

    // Step 1: Exchange public token for access token
    var $exchange_payload {
      value = {
        client_id: $env.PLAID_CLIENT_ID,
        secret: $env.PLAID_SECRET,
        public_token: $input.public_token
      }
    }

    api.request {
      url = $base_url ~ "/item/public_token/exchange"
      method = "POST"
      params = $exchange_payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $exchange_result

    conditional {
      if ($exchange_result.response.status != 200) {
        var $error_msg {
          value = "Plaid token exchange failed: " ~ ($exchange_result.response.result.error_message ?? "Unknown error")
        }

        db.add plaid_log {
          data = {
            operation: "token_exchange",
            status: "failed",
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "PlaidTokenExchangeError"
          value = $error_msg
        }
      }
    }

    var $access_token {
      value = $exchange_result.response.result.access_token
    }

    var $item_id {
      value = $exchange_result.response.result.item_id
    }

    // Log successful token exchange
    db.add plaid_log {
      data = {
        operation: "token_exchange",
        status: "success",
        item_id: $item_id,
        created_at: now
      }
    } as $log_entry

    // Step 2: Get account balances using access token
    var $balance_payload {
      value = {
        client_id: $env.PLAID_CLIENT_ID,
        secret: $env.PLAID_SECRET,
        access_token: $access_token
      }
    }

    api.request {
      url = $base_url ~ "/accounts/balance/get"
      method = "POST"
      params = $balance_payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $balance_result

    conditional {
      if ($balance_result.response.status != 200) {
        var $error_msg {
          value = "Plaid balance fetch failed: " ~ ($balance_result.response.result.error_message ?? "Unknown error")
        }

        db.add plaid_log {
          data = {
            operation: "balance_fetch",
            status: "failed",
            item_id: $item_id,
            error_message: $error_msg,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "PlaidBalanceError"
          value = $error_msg
        }
      }
    }

    // Log successful balance fetch
    db.add plaid_log {
      data = {
        operation: "balance_fetch",
        status: "success",
        item_id: $item_id,
        account_count: $balance_result.response.result.accounts|count,
        created_at: now
      }
    } as $log_entry

    // Build the response
    var $accounts {
      value = $balance_result.response.result.accounts
    }

    var $response_data {
      value = {
        success: true,
        item_id: $item_id,
        accounts: $accounts
      }
    }
  }

  response = $response_data
}
