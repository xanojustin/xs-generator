function "subtract_product_sum" {
  description = "Given an integer n, return the difference between the product of its digits and the sum of its digits"
  
  input {
    int n { description = "The input integer" }
  }
  
  stack {
    // Convert integer to string to iterate over digits
    var $n_str { value = $input.n|to_text }
    
    // Initialize product and sum
    var $product { value = 1 }
    var $sum { value = 0 }
    
    // Split the string into individual digit characters
    var $digits { value = $n_str|split:"" }
    
    // Iterate over each digit character
    foreach ($digits) {
      each as $digit_char {
        // Convert character back to integer
        var $digit { value = $digit_char|to_int }
        
        // Update product and sum
        var.update $product { value = $product * $digit }
        var.update $sum { value = $sum + $digit }
      }
    }
    
    // Calculate the result: product - sum
    var $result { value = $product - $sum }
  }
  
  response = $result
}
