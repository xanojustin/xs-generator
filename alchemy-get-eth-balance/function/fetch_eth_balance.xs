function "fetch_eth_balance" {
  input {
    text wallet_address
  }
  stack {
    // Validate wallet address format (basic check for 0x prefix and 42 chars)
    precondition ($input.wallet_address != null && $input.wallet_address != "") {
      error_type = "inputerror"
      error = "Wallet address is required"
    }
    
    precondition ($input.wallet_address|strlen == 42 && $input.wallet_address|substr:0:2 == "0x") {
      error_type = "inputerror"
      error = "Invalid Ethereum wallet address format"
    }
    
    // Build Alchemy API URL
    var $alchemy_url {
      value = "https://eth-mainnet.g.alchemy.com/v2/" ~ $env.ALCHEMY_API_KEY
    }
    
    // Prepare JSON-RPC payload for eth_getBalance
    var $payload {
      value = {
        jsonrpc: "2.0",
        method: "eth_getBalance",
        params: [$input.wallet_address, "latest"],
        id: 1
      }
    }
    
    // Make request to Alchemy API
    api.request {
      url = $alchemy_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result
    
    // Check for HTTP errors
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Alchemy API error: HTTP " ~ ($api_result.response.status|to_text)
    }
    
    // Check for JSON-RPC errors
    conditional {
      if ($api_result.response.result.error != null) {
        throw {
          name = "AlchemyError"
          value = "Alchemy API error: " ~ ($api_result.response.result.error.message|to_text)
        }
      }
    }
    
    // Get the balance in wei (hex string)
    var $balance_wei_hex {
      value = $api_result.response.result.result
    }
    
    // Convert hex wei to decimal wei
    var $balance_wei {
      value = $balance_wei_hex|hexdec
    }
    
    // Convert wei to ETH (divide by 10^18)
    var $balance_eth {
      value = $balance_wei / 1000000000000000000
    }
    
    // Format the response
    var $response {
      value = {
        wallet_address: $input.wallet_address,
        balance_wei: $balance_wei,
        balance_eth: $balance_eth,
        network: "ethereum-mainnet",
        timestamp: now
      }
    }
    
    // Log the query to database
    db.add "wallet_query" {
      data = {
        wallet_address: $input.wallet_address,
        balance_eth: $balance_eth,
        queried_at: now
      }
    } as $query_record
    
    var.update $response {
      value = $response|set:"query_id":$query_record.id
    }
  }
  response = $response
}
