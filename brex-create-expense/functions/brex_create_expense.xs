function "brex_create_expense" {
  description = "Create a Brex expense with optional receipt and categorize business spending"
  input {
    text merchant_name filters=trim {
      description = "Name of the merchant where the expense was made"
    }
    decimal amount filters=min:0.01 {
      description = "Expense amount (positive number)"
    }
    text currency? filters=trim|upper {
      description = "Currency code (default: USD)"
    }
    text category? filters=trim {
      description = "Expense category (e.g., meals, travel, software, office_supplies)"
    }
    text memo? filters=trim {
      description = "Optional memo or note for the expense"
    }
    date purchase_date? {
      description = "Date of purchase (default: today)"
    }
    text receipt_url? filters=trim {
      description = "Optional URL to receipt image or document"
    }
  }
  stack {
    precondition (($input.merchant_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Merchant name is required"
    }

    precondition ($input.amount > 0) {
      error_type = "inputerror"
      error = "Amount must be greater than 0"
    }

    var $expense_currency {
      value = ($input.currency|is_empty) == false ? $input.currency : "USD"
    }

    var $expense_category {
      value = ($input.category|is_empty) == false ? $input.category : "uncategorized"
    }

    var $expense_memo {
      value = ($input.memo|is_empty) == false ? $input.memo : ("Expense at " ~ $input.merchant_name)
    }

    var $transaction_date {
      value = ($input.purchase_date|is_empty) == false ? $input.purchase_date : "now"
    }

    var $expense_body {
 value = {
        merchant_name: $input.merchant_name,
        amount: $input.amount,
        currency: $expense_currency,
        category: $expense_category,
        memo: $expense_memo,
        purchase_date: $transaction_date
      }
    }

    api.request {
      url = "https://platform.brexapis.com/v1/expenses"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.brex_api_token,
        "Content-Type: application/json"
      ]
      params = $expense_body
    } as $expense_result

    var $expense_status {
      value = $expense_result.response.status
    }

    var $error_message {
      value = ($expense_result.response.body.message|is_empty) == false ? $expense_result.response.body.message : "Unknown error"
    }

    precondition ($expense_status == 200 || $expense_status == 201) {
      error_type = "standard"
      error = "Failed to create Brex expense: " ~ $error_message
    }

    var $expense_id {
      value = $expense_result.response.body.id
    }

    var $receipt_uploaded {
      value = false
    }

    conditional {
      if (($input.receipt_url|is_empty) == false) {
        var $receipt_body {
          value = {
            receipt_url: $input.receipt_url
          }
        }

        api.request {
          url = "https://platform.brexapis.com/v1/expenses/" ~ $expense_id ~ "/receipt"
          method = "POST"
          headers = [
            "Authorization: Bearer " ~ $env.brex_api_token,
            "Content-Type: application/json"
          ]
          params = $receipt_body
        } as $receipt_result

        conditional {
          if ($receipt_result.response.status == 200 || $receipt_result.response.status == 201) {
            var.update $receipt_uploaded {
              value = true
            }
          }
        }
      }
    }

    var $expense_data {
      value = $expense_result.response.body
    }
  }
  response = {
    success: true,
    expense_id: $expense_id,
    merchant_name: $input.merchant_name,
    amount: $input.amount,
    currency: $expense_currency,
    category: $expense_category,
    memo: $expense_memo,
    status: $expense_data.status,
    receipt_uploaded: $receipt_uploaded,
    created_at: $expense_data.created_at,
    brex_url: "https://dashboard.brex.com/expenses/" ~ $expense_id
  }
}
