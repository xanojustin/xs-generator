function "create_invoice" {
  description = "Create a new invoice in QuickBooks Online"
  input {
    text customer_name filters=trim
    email customer_email filters=lower
    object[] line_items {
      schema {
        text description
        decimal amount filters=min:0
        int quantity filters=min:1
      }
    }
    text due_date
  }
  stack {
    // Validate required environment variables
    precondition ($env.quickbooks_access_token != null && $env.quickbooks_access_token != "") {
      error_type = "standard"
      error = "Missing required environment variable: quickbooks_access_token"
    }
    precondition ($env.quickbooks_realm_id != null && $env.quickbooks_realm_id != "") {
      error_type = "standard"
      error = "Missing required environment variable: quickbooks_realm_id"
    }

    // Determine base URL based on environment (default to sandbox)
    var $base_url { value = "https://sandbox-quickbooks.api.intuit.com" }
    conditional {
      if ($env.quickbooks_environment == "production") {
        var.update $base_url {
          value = "https://quickbooks.api.intuit.com"
        }
      }
    }

    // Build line items for QuickBooks format
    var $qb_line_items { value = [] }
    foreach ($input.line_items) {
      each as $item {
        var $line_item {
          value = {
            DetailType: "SalesItemLineDetail",
            Amount: $item.amount * $item.quantity,
            SalesItemLineDetail: {
              ItemRef: {
                name: $item.description,
                value: "1"
              },
              Qty: $item.quantity,
              UnitPrice: $item.amount
            },
            Description: $item.description
          }
        }
        var.update $qb_line_items {
          value = $qb_line_items|push:$line_item
        }
      }
    }

    // Calculate total amount
    var $total_amount { value = 0 }
    foreach ($input.line_items) {
      each as $item {
        math.add $total_amount {
          value = $item.amount * $item.quantity
        }
      }
    }

    // Build the invoice payload
    var $invoice_payload {
      value = {
        Line: $qb_line_items,
        CustomerRef: {
          name: $input.customer_name,
          value: "1"
        },
        DueDate: $input.due_date,
        TotalAmt: $total_amount,
        EmailStatus: "NotSet",
        Balance: $total_amount
      }
    }

    // Create the invoice in QuickBooks
    api.request {
      url = $base_url ~ "/v3/company/" ~ $env.quickbooks_realm_id ~ "/invoice"
      method = "POST"
      params = $invoice_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.quickbooks_access_token,
        "Accept: application/json"
      ]
      timeout = 30
    } as $qb_response

    // Handle the response
    conditional {
      if ($qb_response.response.status >= 200 && $qb_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            invoice_id: $qb_response.response.result.Invoice.Id,
            invoice_number: $qb_response.response.result.Invoice.DocNumber,
            total_amount: $qb_response.response.result.Invoice.TotalAmt,
            customer: $input.customer_name,
            due_date: $input.due_date,
            quickbooks_response: $qb_response.response.result
          }
        }
      }
      elseif ($qb_response.response.status == 400) {
        throw {
          name = "BadRequest"
          value = "Invalid request to QuickBooks: " ~ ($qb_response.response.result|json_encode)
        }
      }
      elseif ($qb_response.response.status == 401) {
        throw {
          name = "Unauthorized"
          value = "QuickBooks authentication failed. Please check your access token."
        }
      }
      elseif ($qb_response.response.status == 403) {
        throw {
          name = "Forbidden"
          value = "Access forbidden to QuickBooks. Please check your realm ID and permissions."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "QuickBooks API returned status " ~ ($qb_response.response.status|to_text) ~ ": " ~ ($qb_response.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}
