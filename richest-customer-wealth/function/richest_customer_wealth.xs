function "richest_customer_wealth" {
  description = "Calculate the maximum wealth among all customers"
  input {
    json accounts { description = "2D array where accounts[i][j] is the money customer i has in bank j" }
  }
  stack {
    var $max_wealth { value = 0 }
    
    foreach ($input.accounts) {
      each as $customer {
        var $customer_wealth { value = 0 }
        
        foreach ($customer) {
          each as $bank {
            math.add $customer_wealth { value = $bank }
          }
        }
        
        conditional {
          if ($customer_wealth > $max_wealth) {
            var.update $max_wealth { value = $customer_wealth }
          }
        }
      }
    }
  }
  response = $max_wealth
}
