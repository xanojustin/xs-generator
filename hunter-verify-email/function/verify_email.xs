function "verify_email" {
  input {
    text email
  }
  stack {
    precondition ($input.email != null && $input.email != "") {
      error_type = "inputerror"
      error = "Email address is required"
    }

    precondition ($input.email|contains:"@") {
      error_type = "inputerror"
      error = "Invalid email format: missing @ symbol"
    }

    var $api_url {
      value = "https://api.hunter.io/v2/email-verifier?email=" ~ ($input.email|url_encode) ~ "&api_key=" ~ $env.hunter_api_key
    }

    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $data { value = $api_result.response.result }
        var $email_data { value = $data|get:"data":{} }
        
        var $verification {
          value = {
            email: $input.email,
            status: $email_data|get:"status":"unknown",
            result: $email_data|get:"result":"unknown",
            score: $email_data|get:"score":0,
            regexp: $email_data|get:"regexp":false,
            gibberish: $email_data|get:"gibberish":false,
            disposable: $email_data|get:"disposable":false,
            webmail: $email_data|get:"webmail":false,
            mx_records: $email_data|get:"mx_records":false,
            smtp_server: $email_data|get:"smtp_server":false,
            smtp_check: $email_data|get:"smtp_check":false,
            accept_all: $email_data|get:"accept_all":false,
            block: $email_data|get:"block":false,
            sources: $email_data|get:"sources":[],
            verified_at: now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Hunter API key"
        }
      }
      elseif ($api_result.response.status == 422) {
        var $error_data { value = $api_result.response.result }
        throw {
          name = "ValidationError"
          value = $error_data|get:"errors"|get:0|get:"details":"Invalid email format"
        }
      }
      elseif ($api_result.response.status == 429) {
        throw {
          name = "RateLimitError"
          value = "Hunter API rate limit exceeded. Please try again later."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Hunter API error: " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }
  response = $verification
}
