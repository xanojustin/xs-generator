function "gumroad_create_sale" {
  description = "Create a sale on Gumroad for a digital product"
  input {
    text product_id filters=trim { description = "Gumroad product ID (permalink)" }
    email email filters=trim { description = "Customer email address" }
    int price? filters=min:0 { description = "Price in cents (optional, uses product default if not provided)" }
    text offer_code? filters=trim { description = "Offer code to apply (optional)" }
  }
  stack {
    var $payload {
      value = {
        product_id: $input.product_id,
        email: $input.email
      }
    }

    conditional {
      if ($input.price > 0) {
        var.update $payload.price { value = $input.price }
      }
    }

    conditional {
      if ($input.offer_code != "") {
        var.update $payload.offer_code { value = $input.offer_code }
      }
    }

    api.request {
      url = "https://api.gumroad.com/v2/sales"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.gumroad_access_token
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $sale {
          value = $api_result.response.result
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "Unauthorized"
          value = "Invalid Gumroad access token"
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFound"
          value = "Product not found: " ~ $input.product_id
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Gumroad API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = {
    success: true,
    sale: $sale
  }
}
