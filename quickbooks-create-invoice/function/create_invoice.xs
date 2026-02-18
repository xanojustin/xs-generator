function "create_invoice" {
  input {
    text customer_id
    text customer_name
    text customer_email
    text[] item_names
    decimal[] item_amounts
    text[] item_descriptions?
    int[] item_quantities?
    text invoice_date?=""
    text due_date?=""
    text memo?=""
  }

  stack {
    // Validate required inputs
    precondition ($input.customer_id != "" && $input.customer_id != null) {
      error_type = "inputerror"
      error = "customer_id is required"
    }

    precondition ($input.customer_name != "" && $input.customer_name != null) {
      error_type = "inputerror"
      error = "customer_name is required"
    }

    precondition (($input.item_names|count) > 0) {
      error_type = "inputerror"
      error = "at least one item is required"
    }

    precondition (($input.item_names|count) == ($input.item_amounts|count)) {
      error_type = "inputerror"
      error = "item_names and item_amounts must have the same count"
    }

    // Set default dates if not provided - QuickBooks accepts ISO format dates
    var $effective_invoice_date {
      value = ($input.invoice_date != "") ? $input.invoice_date : now
    }

    var $effective_due_date {
      value = ($input.due_date != "") ? $input.due_date : now
    }

    // Get item count
    var $item_count {
      value = $input.item_names|count
    }

    // Build line items based on count and calculate total
    // Using ternary expressions to calculate total based on item count
    var $total_amount {
      value = ($item_count == 1) ? $input.item_amounts[0] : (($item_count == 2) ? ($input.item_amounts[0] + $input.item_amounts[1]) : ($input.item_amounts[0] + $input.item_amounts[1] + $input.item_amounts[2]))
    }

    // Build line items array
    var $line_items {
      value = ($item_count == 1) ? [
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[0],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 0) ? $input.item_descriptions[0] : $input.item_names[0],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1,
            UnitPrice: $input.item_amounts[0] / (($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1)
          }
        }
      ] : (($item_count == 2) ? [
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[0],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 0) ? $input.item_descriptions[0] : $input.item_names[0],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1,
            UnitPrice: $input.item_amounts[0] / (($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1)
          }
        },
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[1],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 1) ? $input.item_descriptions[1] : $input.item_names[1],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 1) ? $input.item_quantities[1] : 1,
            UnitPrice: $input.item_amounts[1] / (($input.item_quantities != null && ($input.item_quantities|count) > 1) ? $input.item_quantities[1] : 1)
          }
        }
      ] : [
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[0],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 0) ? $input.item_descriptions[0] : $input.item_names[0],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1,
            UnitPrice: $input.item_amounts[0] / (($input.item_quantities != null && ($input.item_quantities|count) > 0) ? $input.item_quantities[0] : 1)
          }
        },
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[1],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 1) ? $input.item_descriptions[1] : $input.item_names[1],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 1) ? $input.item_quantities[1] : 1,
            UnitPrice: $input.item_amounts[1] / (($input.item_quantities != null && ($input.item_quantities|count) > 1) ? $input.item_quantities[1] : 1)
          }
        },
        {
          DetailType: "SalesItemLineDetail",
          Amount: $input.item_amounts[2],
          Description: ($input.item_descriptions != null && ($input.item_descriptions|count) > 2) ? $input.item_descriptions[2] : $input.item_names[2],
          SalesItemLineDetail: {
            Qty: ($input.item_quantities != null && ($input.item_quantities|count) > 2) ? $input.item_quantities[2] : 1,
            UnitPrice: $input.item_amounts[2] / (($input.item_quantities != null && ($input.item_quantities|count) > 2) ? $input.item_quantities[2] : 1)
          }
        }
      ])
    }

    // Build the invoice payload
    var $payload {
      value = {
        CustomerRef: {
          value: $input.customer_id
        },
        Line: $line_items,
        TxnDate: $effective_invoice_date,
        DueDate: $effective_due_date,
        BillEmail: {
          Address: $input.customer_email
        },
        CustomerMemo: {
          value: ($input.memo != "") ? $input.memo : "Thank you for your business!"
        }
      }
    }

    // Construct the QuickBooks API URL
    var $api_url {
      value = "https://quickbooks.api.intuit.com/v3/company/" ~ $env.QUICKBOOKS_REALM_ID ~ "/invoice"
    }

    // Create the invoice via QuickBooks API
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.QUICKBOOKS_ACCESS_TOKEN,
        "Content-Type: application/json",
        "Accept: application/json"
      ]
      timeout = 30
    } as $qb_result

    // Handle QuickBooks response
    conditional {
      if ($qb_result.response.status >= 200 && $qb_result.response.status < 300) {
        var $invoice {
          value = {
            success: true,
            invoice_id: $qb_result.response.result.Invoice.Id,
            doc_number: $qb_result.response.result.Invoice.DocNumber,
            customer_id: $qb_result.response.result.Invoice.CustomerRef.value,
            customer_name: $input.customer_name,
            total_amount: $total_amount,
            invoice_date: $effective_invoice_date,
            due_date: $effective_due_date,
            balance: $qb_result.response.result.Invoice.Balance,
            invoice_status: $qb_result.response.result.Invoice.Balance == 0 ? "paid" : "open",
            view_invoice_url: "https://app.intuit.com/app/invoice?txnId=" ~ $qb_result.response.result.Invoice.Id,
            created_at: now
          }
        }

        // Log the successful invoice creation
        db.add invoice_log {
          data = {
            invoice_id: $qb_result.response.result.Invoice.Id,
            doc_number: $qb_result.response.result.Invoice.DocNumber,
            customer_id: $input.customer_id,
            customer_name: $input.customer_name,
            customer_email: $input.customer_email,
            total_amount: $total_amount,
            invoice_date: $effective_invoice_date,
            due_date: $effective_due_date,
            status: "created",
            qb_response: $qb_result.response.result,
            created_at: now
          }
        } as $log_entry
      }
      else {
        // API error
        var $error_details {
          value = $qb_result.response.result.fault.error[0].message
        }
        var $error_msg {
          value = "QuickBooks API error: " ~ $error_details
        }

        // Log the failed invoice attempt
        db.add invoice_log {
          data = {
            customer_id: $input.customer_id,
            customer_name: $input.customer_name,
            customer_email: $input.customer_email,
            total_amount: $total_amount,
            invoice_date: $effective_invoice_date,
            due_date: $effective_due_date,
            status: "failed",
            error_message: $error_msg,
            qb_response: $qb_result.response.result,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "QuickBooksAPIError"
          value = $error_msg
        }
      }
    }
  }

  response = $invoice
}
