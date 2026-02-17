function "lemon_squeezy_create_checkout" {
  description = "Create a checkout session using the Lemon Squeezy API"
  input {
    text store_id { description = "Your Lemon Squeezy store ID" }
    text variant_id { description = "The product variant ID to sell" }
    text email { description = "Customer email address" }
    text name { description = "Customer name" }
    text billing_address_country { description = "Two-letter country code (e.g., 'US')" }
    text billing_address_zip { description = "ZIP/postal code" }
  }
  stack {
    var $payload {
      value = {
        data: {
          type: "checkouts",
          attributes: {
            checkout_data: {
              email: $input.email,
              name: $input.name,
              billing_address: {
                country: $input.billing_address_country,
                zip: $input.billing_address_zip
              }
            },
            product_options: {
              enabled_variants: [$input.variant_id],
              redirect_url: "https://your-app.com/thank-you"
            }
          },
          relationships: {
            store: {
              data: {
                type: "stores",
                id: $input.store_id
              }
            },
            variant: {
              data: {
                type: "variants",
                id: $input.variant_id
              }
            }
          }
        }
      }
    }

    api.request {
      url = "https://api.lemonsqueezy.com/v1/checkouts"
      method = "POST"
      params = $payload
      headers = [
        "Accept: application/vnd.api+json",
        "Content-Type: application/vnd.api+json",
        "Authorization: Bearer " ~ $env.lemon_squeezy_api_key
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $checkout { value = $api_result.response.result }
      }
      else {
        throw {
          name = "LemonSqueezyAPIError"
          value = "Lemon Squeezy API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $checkout
}
