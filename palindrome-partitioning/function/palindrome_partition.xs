function "palindrome_partition" {
  description = "Partition a string such that every substring is a palindrome. Returns all possible palindrome partitionings."
  input {
    text s { description = "Input string to partition" }
  }
  stack {
    // Helper function to check if a string is a palindrome
    var $is_palindrome {
      value = """
      function($str) {
        var $left = 0
        var $right = $str|strlen - 1
        while ($left < $right) {
          if ($str[$left] != $str[$right]) {
            return false
          }
          $left = $left + 1
          $right = $right - 1
        }
        return true
      }
      """
    }
    
    // Result array to store all partitions
    var $result { value = [] }
    
    // Current partition being built
    var $current { value = [] }
    
    // Start backtracking from index 0
    // We'll use a while loop with a stack to simulate recursion
    var $stack { value = [{ index: 0, current: [], state: "process" }] }
    
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $frame { value = $stack|last }
        var.update $stack { value = $stack|slice:0:(($stack|count) - 1) }
        
        var $idx { value = $frame.index }
        var $curr { value = $frame.current }
        
        // Base case: if we've reached the end of the string
        conditional {
          if ($idx == ($input.s|strlen)) {
            // Add current partition to results
            var.update $result { value = $result|append:$curr }
          }
          else {
            // Try all possible substrings starting at idx
            var $i { value = $idx }
            while ($i < ($input.s|strlen)) {
              each {
                // Extract substring from idx to i
                var $substr { value = $input.s|substr:$idx:($i + 1 - $idx) }
                
                // Check if it's a palindrome
                var $is_pal { value = true }
                var $left { value = 0 }
                var $right { value = ($substr|strlen) - 1 }
                
                while ($left < $right) {
                  each {
                    conditional {
                      if ($substr[$left] != $substr[$right]) {
                        var.update $is_pal { value = false }
                      }
                    }
                    var.update $left { value = $left + 1 }
                    var.update $right { value = $right - 1 }
                  }
                }
                
                conditional {
                  if ($is_pal) {
                    // Add substring to current partition and continue
                    var $new_curr { value = $curr|append:$substr }
                    var.update $stack { value = $stack|append:{ index: $i + 1, current: $new_curr } }
                  }
                }
                
                var.update $i { value = $i + 1 }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
