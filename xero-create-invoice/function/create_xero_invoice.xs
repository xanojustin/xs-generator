function "create_xero_invoice" {
  input {
    text tenant_id
    text contact_name
    text contact_email?
    text description
    decimal quantity
    decimal unit_amount
    text account_code?="200"
    text invoice_type?="ACCREC"
    text invoice_status?="DRAFT"
    text date?
    text due_date?
  }
  
  stack {
    var $access_token { value = $env.XERO_ACCESS_TOKEN }
    
    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "XERO_ACCESS_TOKEN environment variable is required"
    }
    
    var $contact {
      value = {
        name: $input.contact_name
      }
    }
    
    conditional {
      if ($input.contact_email != null && $input.contact_email != "") {
        var.update $contact {
          value = $contact|set:"emailAddress":$input.contact_email
        }
      }
    }
    
    var $line_amount { value = $input.quantity * $input.unit_amount }
    
    var $line_item {
      value = {
        description: $input.description
        quantity: $input.quantity
        unitAmount: $input.unit_amount
        accountCode: $input.account_code
        lineAmount: $line_amount
      }
    }
    
    var $invoice_date { value = $input.date ?? (now|format_timestamp:"Y-m-d":"UTC") }
    var $invoice_due_date { 
      value = $input.due_date ?? (now|transform_timestamp:"+30 days"|format_timestamp:"Y-m-d":"UTC")
    }
    
    var $invoice_payload {
      value = {
        type: $input.invoice_type
        contact: $contact
        date: $invoice_date
        dueDate: $invoice_due_date
        status: $input.invoice_status
        lineItems: [$line_item]
      }
    }
    
    var $payload {
      value = {
        invoices: [$invoice_payload]
      }
    }
    
    api.request {
      url = "https://api.xero.com/api.xro/2.0/Invoices"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Authorization: Bearer " ~ $access_token
        "Xero-tenant-id: " ~ $input.tenant_id
      ]
      timeout = 30
    } as $xero_response
    
    conditional {
      if ($xero_response.response.status == 200 || $xero_response.response.status == 201) {
        var $response_body { value = $xero_response.response.result }
        var $created_invoice { value = $response_body|get:"Invoices":[]|first }
        
        var $result {
          value = {
            success: true
            invoice_id: $created_invoice|get:"InvoiceID":""
            invoice_number: $created_invoice|get:"InvoiceNumber":""
            status: $created_invoice|get:"Status":""
            total: $created_invoice|get:"Total":0
            amount_due: $created_invoice|get:"AmountDue":0
            date: $created_invoice|get:"Date":""
            due_date: $created_invoice|get:"DueDate":""
            contact_name: $created_invoice|get:"Contact"|get:"Name":""
            line_items_count: ($created_invoice|get:"LineItems":[])|count
          }
        }
      }
      elseif ($xero_response.response.status == 400) {
        var $error_details { value = $xero_response.response.result }
        throw {
          name = "XeroValidationError"
          value = "Xero validation failed: " ~ ($error_details|json_encode)
        }
      }
      elseif ($xero_response.response.status == 401) {
        throw {
          name = "XeroAuthError"
          value = "Xero authentication failed. Check your XERO_ACCESS_TOKEN."
        }
      }
      elseif ($xero_response.response.status == 403) {
        throw {
          name = "XeroTenantError"
          value = "Access denied for the specified Xero tenant. Check your Xero-tenant-id."
        }
      }
      elseif ($xero_response.response.status == 429) {
        throw {
          name = "XeroRateLimitError"
          value = "Xero API rate limit exceeded. Please try again later."
        }
      }
      else {
        throw {
          name = "XeroAPIError"
          value = "Xero API error (status " ~ ($xero_response.response.status|to_text) ~ "): " ~ ($xero_response.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}