// Subsets - Generate all possible subsets of a given set of distinct integers
// Uses iterative approach to build subsets
function "subsets" {
  description = "Returns all possible subsets (the power set) of a given set of distinct integers"
  
  input {
    int[] nums { description = "Array of distinct integers" }
  }
  
  stack {
    // Start with empty subset
    var $result { value = [[]] }
    var $i { value = 0 }
    
    // Iterate through each number
    while ($i < ($input.nums|count)) {
      each {
        var $num { value = $input.nums[$i] }
        var $current_count { value = $result|count }
        var $j { value = 0 }
        
        // For each existing subset, create a new subset with the current number
        while ($j < $current_count) {
          each {
            var $new_subset { value = $result[$j]|merge:[$num] }
            var $result {
              value = $result|merge:[$new_subset]
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
