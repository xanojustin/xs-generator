// Design a Simple Bank System
// Supports: deposit, withdraw, transfer, and check balance operations
function "bank-system" {
  description = "Simple bank system with deposit, withdraw, transfer, and balance operations"
  
  input {
    text operation { description = "Operation type: deposit, withdraw, transfer, balance" }
    int account_id { description = "Account ID" }
    int? amount { description = "Amount for deposit/withdraw/transfer (optional for balance)" }
    int? target_account_id { description = "Target account ID for transfer" }
  }
  
  stack {
    // In-memory account storage (in a real system, this would be a database)
    var $accounts { 
      value = {
        "1": { balance: 1000 },
        "2": { balance: 500 },
        "3": { balance: 0 }
      }
    }
    
    var $result { value = {} }
    var $account_key { value = $input.account_id|to_text }
    
    switch ($input.operation) {
      case ("deposit") {
        conditional {
          if ($input.amount == null || $input.amount <= 0) {
            var $result { 
              value = { 
                success: false, 
                error: "Invalid deposit amount" 
              } 
            }
          }
          else {
            var $current_balance { 
              value = $accounts|get:$account_key|get:"balance"
            }
            var $new_balance { value = $current_balance + $input.amount }
            var $account_obj { value = { balance: $new_balance } }
            var $accounts { 
              value = $accounts|set:$account_key:$account_obj
            }
            var $result { 
              value = { 
                success: true, 
                account_id: $input.account_id,
                balance: $new_balance,
                deposited: $input.amount 
              } 
            }
          }
        }
      } break
      
      case ("withdraw") {
        conditional {
          if ($input.amount == null || $input.amount <= 0) {
            var $result { 
              value = { 
                success: false, 
                error: "Invalid withdrawal amount" 
              } 
            }
          }
          else {
            var $current_balance { 
              value = $accounts|get:$account_key|get:"balance"
            }
            conditional {
              if ($current_balance < $input.amount) {
                var $result { 
                  value = { 
                    success: false, 
                    error: "Insufficient funds" 
                  } 
                }
              }
              else {
                var $new_balance { value = $current_balance - $input.amount }
                var $account_obj { value = { balance: $new_balance } }
                var $accounts { 
                  value = $accounts|set:$account_key:$account_obj
                }
                var $result { 
                  value = { 
                    success: true, 
                    account_id: $input.account_id,
                    balance: $new_balance,
                    withdrawn: $input.amount 
                  } 
                }
              }
            }
          }
        }
      } break
      
      case ("transfer") {
        conditional {
          if ($input.amount == null || $input.amount <= 0) {
            var $result { 
              value = { 
                success: false, 
                error: "Invalid transfer amount" 
              } 
            }
          }
          elseif ($input.target_account_id == null) {
            var $result { 
              value = { 
                success: false, 
                error: "Target account required" 
              } 
            }
          }
          else {
            var $target_key { value = $input.target_account_id|to_text }
            var $from_balance { 
              value = $accounts|get:$account_key|get:"balance"
            }
            conditional {
              if ($from_balance < $input.amount) {
                var $result { 
                  value = { 
                    success: false, 
                    error: "Insufficient funds" 
                  } 
                }
              }
              else {
                var $to_balance { 
                  value = $accounts|get:$target_key|get:"balance"
                }
                var $new_from_balance { value = $from_balance - $input.amount }
                var $new_to_balance { value = $to_balance + $input.amount }
                var $from_account_obj { value = { balance: $new_from_balance } }
                var $to_account_obj { value = { balance: $new_to_balance } }
                var $accounts { 
                  value = $accounts|set:$account_key:$from_account_obj|set:$target_key:$to_account_obj
                }
                var $result { 
                  value = { 
                    success: true, 
                    from_account: $input.account_id,
                    to_account: $input.target_account_id,
                    from_balance: $new_from_balance,
                    to_balance: $new_to_balance,
                    transferred: $input.amount 
                  } 
                }
              }
            }
          }
        }
      } break
      
      case ("balance") {
        var $balance { 
          value = $accounts|get:$account_key|get:"balance"
        }
        var $result { 
          value = { 
            success: true, 
            account_id: $input.account_id,
            balance: $balance 
          } 
        }
      } break
      
      default {
        var $result { 
          value = { 
            success: false, 
            error: "Unknown operation" 
          } 
        }
      }
    }
  }
  
  response = $result
}
