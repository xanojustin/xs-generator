function "verify_turnstile_token" {
  input {
    text token filters=trim
    text remoteip?=""
  }

  stack {
    precondition ($input.token != "") {
      error_type = "inputerror"
      error = "Turnstile token is required"
    }

    var $verify_payload {
      value = {
        secret: $env.cloudflare_turnstile_secret_key,
        response: $input.token
      }
    }

    conditional {
      if ($input.remoteip != "") {
        var $verify_payload {
          value = {
            secret: $env.cloudflare_turnstile_secret_key,
            response: $input.token,
            remoteip: $input.remoteip
          }
        }
      }
    }

    api.request {
      url = "https://challenges.cloudflare.com/turnstile/v0/siteverify"
      method = "POST"
      params = $verify_payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $verify_result

    precondition ($verify_result.response.status == 200) {
      error_type = "standard"
      error = "Turnstile verification failed: " ~ ($verify_result.response.result|json_encode)
    }

    var $verification {
      value = $verify_result.response.result
    }

    conditional {
      if ($verification.success == true) {
        var $result_data {
          value = {
            success: true,
            challenge_ts: $verification.challenge_ts,
            hostname: $verification.hostname,
            action: $verification.action ?? "",
            cdata: $verification.cdata ?? ""
          }
        }
      }
      else {
        var $error_codes {
          value = $verification["error-codes"] ?? []
        }
        throw {
          name = "TurnstileVerificationFailed"
          value = "Token verification failed: " ~ ($error_codes|json_encode)
        }
      }
    }
  }

  response = $result_data
}
