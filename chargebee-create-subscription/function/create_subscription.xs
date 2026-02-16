function "create_subscription" {
  description = "Create a subscription in Chargebee with optional new customer"
  input {
    text plan_id filters=trim { description = "Chargebee plan ID (e.g., 'basic-plan' or 'plan_123')" }
    text customer_email filters=trim { description = "Customer email address" }
    text? customer_id filters=trim { description = "Existing Chargebee customer ID (if not creating new customer)" }
    text? customer_first_name filters=trim { description = "Customer first name (for new customer)" }
    text? customer_last_name filters=trim { description = "Customer last name (for new customer)" }
    text? billing_address_line1 filters=trim { description = "Billing address line 1" }
    text? billing_address_city filters=trim { description = "Billing city" }
    text? billing_address_state filters=trim { description = "Billing state/province" }
    text? billing_address_zip filters=trim { description = "Billing ZIP/postal code" }
    text? billing_address_country filters=trim { description = "Billing country code (e.g., 'US')" }
    integer? trial_days { description = "Number of trial days (optional, uses plan default if not set)" }
    text? coupon_ids filters=trim { description = "Comma-separated coupon IDs to apply" }
    text? po_number filters=trim { description = "Purchase order number for invoicing" }
  }

  stack {
    // Get API credentials from environment
    var $api_key { value = $env.CHARGEBEE_API_KEY }
    var $site_name { value = $env.CHARGEBEE_SITE_NAME }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "CHARGEBEE_API_KEY environment variable not configured"
    }

    // Validate site name is configured
    precondition ($site_name != null && $site_name != "") {
      error_type = "standard"
      error = "CHARGEBEE_SITE_NAME environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.plan_id != null && $input.plan_id != "") {
      error_type = "inputerror"
      error = "Plan ID is required"
    }

    precondition ($input.customer_email != null && $input.customer_email != "") {
      error_type = "inputerror"
      error = "Customer email is required"
    }

    // Build the base URL
    var $base_url {
      value = "https://" ~ $site_name ~ ".chargebee.com/api/v2"
    }

    // Build the request payload
    var $payload {
      value = {
        plan_id: $input.plan_id,
        customer_email: $input.customer_email
      }
    }

    // Add customer ID if provided (use existing customer)
    conditional {
      if ($input.customer_id != null && $input.customer_id != "") {
        var.update $payload {
          value = $payload|set:"customer_id":$input.customer_id
        }
      }
    }

    // Add customer name if creating new customer
    conditional {
      if ($input.customer_first_name != null && $input.customer_first_name != "") {
        var.update $payload {
          value = $payload|set:"customer_first_name":$input.customer_first_name
        }
      }
    }

    conditional {
      if ($input.customer_last_name != null && $input.customer_last_name != "") {
        var.update $payload {
          value = $payload|set:"customer_last_name":$input.customer_last_name
        }
      }
    }

    // Add billing address if any field is provided
    conditional {
      if (($input.billing_address_line1 != null && $input.billing_address_line1 != "") ||
          ($input.billing_address_city != null && $input.billing_address_city != "") ||
          ($input.billing_address_state != null && $input.billing_address_state != "")) {
        var $billing_address { value = {} }
        conditional {
          if ($input.billing_address_line1 != null && $input.billing_address_line1 != "") {
            var.update $billing_address {
              value = $billing_address|set:"line1":$input.billing_address_line1
            }
          }
        }
        conditional {
          if ($input.billing_address_city != null && $input.billing_address_city != "") {
            var.update $billing_address {
              value = $billing_address|set:"city":$input.billing_address_city
            }
          }
        }
        conditional {
          if ($input.billing_address_state != null && $input.billing_address_state != "") {
            var.update $billing_address {
              value = $billing_address|set:"state":$input.billing_address_state
            }
          }
        }
        conditional {
          if ($input.billing_address_zip != null && $input.billing_address_zip != "") {
            var.update $billing_address {
              value = $billing_address|set:"zip":$input.billing_address_zip
            }
          }
        }
        conditional {
          if ($input.billing_address_country != null && $input.billing_address_country != "") {
            var.update $billing_address {
              value = $billing_address|set:"country":$input.billing_address_country
            }
          }
        }
        var.update $payload {
          value = $payload|set:"billing_address":$billing_address
        }
      }
    }

    // Add trial days if specified
    conditional {
      if ($input.trial_days != null) {
        var.update $payload {
          value = $payload|set:"trial_end":("+" ~ ($input.trial_days|to_text) ~ "d")
        }
      }
    }

    // Add coupon IDs if provided
    conditional {
      if ($input.coupon_ids != null && $input.coupon_ids != "") {
        var.update $payload {
          value = $payload|set:"coupon_ids":$input.coupon_ids
        }
      }
    }

    // Add PO number if provided
    conditional {
      if ($input.po_number != null && $input.po_number != "") {
        var.update $payload {
          value = $payload|set:"po_number":$input.po_number
        }
      }
    }

    // Send the request to Chargebee
    api.request {
      url = $base_url ~ "/subscriptions"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ ($api_key|base64_encode)
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $subscription_id { value = null }
    var $customer_id_result { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $subscription_data { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $subscription_data { value = $response_body|get:"subscription" }
        var $customer_data { value = $response_body|get:"customer" }
        conditional {
          if ($subscription_data != null) {
            var $subscription_id { value = $subscription_data|get:"id" }
            var $status { value = $subscription_data|get:"status" }
          }
        }
        conditional {
          if ($customer_data != null) {
            var $customer_id_result { value = $customer_data|get:"id" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        conditional {
          if ($error_body != null) {
            var $error_list { value = $error_body|get:"errors" }
            conditional {
              if ($error_list != null && ($error_list|count) > 0) {
                var $first_error { value = $error_list|first }
                var $error_message {
                  value = $first_error|get:"message"
                }
              }
            }
          }
        }
        conditional {
          if ($error_message == null || $error_message == "") {
            var $error_message {
              value = "Chargebee API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    subscription_id: $subscription_id,
    customer_id: $customer_id_result,
    status: $status,
    subscription_data: $subscription_data,
    error: $error_message
  }
}
