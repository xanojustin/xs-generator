// Permutation Sequence - Classic coding exercise
// Given n and k, return the kth permutation sequence of numbers [1, 2, ..., n]
// Uses factorial number system for O(n^2) time without generating all permutations
function "permutation_sequence" {
  description = "Returns the kth permutation sequence of numbers 1 to n"
  
  input {
    int n { description = "The range of numbers (1 to n)" }
    int k { description = "The kth permutation to find (1-indexed)" }
  }
  
  stack {
    // Precompute factorials from 0! to (n-1)!
    var $factorials { value = [1] }
    var $i { value = 1 }
    
    while ($i < $input.n) {
      each {
        var $prev_factorial { value = $factorials|get:(($i - 1)|to_text) }
        var $new_factorial { value = $prev_factorial * $i }
        var $factorials {
          value = $factorials|merge:[$new_factorial]
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Create list of available numbers [1, 2, ..., n]
    var $available { value = [] }
    var $num { value = 1 }
    
    while ($num <= $input.n) {
      each {
        var $available {
          value = $available|merge:[$num]
        }
        var.update $num { value = $num + 1 }
      }
    }
    
    // Build the result using factorial number system
    var $result { value = "" }
    var $remaining_k { value = $input.k }
    var $position { value = $input.n }
    
    while ($position > 0) {
      each {
        // Get factorial for current position
        var $fact { value = $factorials|get:(($position - 1)|to_text) }
        
        // Calculate which number to pick
        var $index { value = ($remaining_k - 1) / $fact }
        
        // Get the number at that index
        var $selected_num { value = $available|get:($index|to_text) }
        
        // Append to result
        var $result {
          value = $result ~ ($selected_num|to_text)
        }
        
        // Remove the used number from available list
        var $new_available { value = [] }
        var $j { value = 0 }
        
        foreach ($available) {
          each as $avail_num {
            conditional {
              if ($j != $index) {
                var $new_available {
                  value = $new_available|merge:[$avail_num]
                }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        var $available { value = $new_available }
        
        // Update remaining_k
        var $remaining_k {
          value = ($remaining_k - 1) % $fact + 1
        }
        
        var.update $position { value = $position - 1 }
      }
    }
  }
  
  response = $result
}
