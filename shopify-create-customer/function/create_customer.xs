function "create_customer" {
  description = "Create a new customer in Shopify store"
  input {
    email email filters=lower
    text first_name
    text last_name
    text phone?
    bool verified_email?=true
    bool send_email_invite?=false
  }
  stack {
    // Build the Shopify API URL
    var $shop_domain {
      value = $env.shopify_shop_domain
    }

    var $api_url {
      value = "https://" ~ $shop_domain ~ "/admin/api/2024-01/customers.json"
    }

    // Build customer payload
    var $customer_data {
      value = {
        customer: {
          email: $input.email,
          first_name: $input.first_name,
          last_name: $input.last_name,
          verified_email: $input.verified_email,
          send_email_invite: $input.send_email_invite
        }
      }
    }

    // Add phone if provided
    conditional {
      if ($input.phone != null && $input.phone != "") {
        var.update $customer_data.customer.phone {
          value = $input.phone
        }
      }
    }

    // Make API request to Shopify
    api.request {
      url = $api_url
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "X-Shopify-Access-Token: " ~ $env.shopify_access_token
      ]
      params = $customer_data
      timeout = 30
    } as $api_result

    // Check for API errors
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Shopify API error: " ~ $api_result.response.result|json_encode
    }

    // Extract customer from response
    var $created_customer {
      value = $api_result.response.result.customer
    }

    // Log success
    debug.log {
      value = "Created Shopify customer: " ~ ($created_customer.id|to_text) ~ " - " ~ $input.email
    }
  }
  response = {
    success: true,
    customer: $created_customer,
    shop_domain: $shop_domain
  }
}
