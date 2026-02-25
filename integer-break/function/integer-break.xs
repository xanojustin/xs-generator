// Integer Break - Dynamic Programming Exercise
// Given an integer n, break it into at least two positive integers 
// to maximize the product. Return the maximum product.
function "integer-break" {
  description = "Break integer n into sum of at least two positive integers to maximize product"

  input {
    int n { description = "Integer to break (n >= 2)" }
  }

  stack {
    // Handle base cases
    conditional {
      if (`$input.n == 2`) {
        return { value = 1 }
      }
      elseif (`$input.n == 3`) {
        return { value = 2 }
      }
    }

    // dp[i] = maximum product for breaking integer i
    var $dp { value = [] }
    
    // Initialize dp array - dp[0] and dp[1] are not used
    // dp[i] stores max product for integer i
    var $i { value = 0 }
    while (`$i <= $input.n`) {
      each {
        var $dp { value = $dp|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Base cases: these are the values when we DON'T break further
    // For 2: max product is 2 (but when used as part of larger sum, we don't break it)
    // For 3: max product is 3
    var $dp { value = $dp|set:"2":2 }
    var $dp { value = $dp|set:"3":3 }
    
    // Fill dp table
    var $i { value = 4 }
    while (`$i <= $input.n`) {
      each {
        // Try all possible breaks: j and (i-j)
        var $max_product { value = 0 }
        var $j { value = 1 }
        
        while (`$j < $i`) {
          each {
            // Product when breaking i into j and (i-j)
            var $product { value = ($dp|get:($j|to_text)) * ($dp|get:(($i - $j)|to_text)) }
            
            conditional {
              if (`$product > $max_product`) {
                var $max_product { value = $product }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        var $dp { value = $dp|set:($i|to_text):$max_product }
        var.update $i { value = $i + 1 }
      }
    }
    
    // For the original n, we MUST break it into at least two parts
    // So we need to find the best break explicitly (not using dp[n] directly)
    var $result { value = 0 }
    var $j { value = 1 }
    
    while (`$j < $input.n`) {
      each {
        var $product { value = ($dp|get:($j|to_text)) * ($dp|get:(($input.n - $j)|to_text)) }
        
        conditional {
          if (`$product > $result`) {
            var $result { value = $product }
          }
        }
        
        var.update $j { value = $j + 1 }
      }
    }
  }

  response = $result
}
