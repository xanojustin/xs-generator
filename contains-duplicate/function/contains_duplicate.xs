// Contains Duplicate - Classic coding exercise
// Given an array of integers, determine if the array contains any duplicates
// Returns true if any value appears at least twice, false if all elements are distinct
function "contains_duplicate" {
  description = "Determines if an array contains any duplicate elements"
  
  input {
    int[] nums { description = "Array of integers to check for duplicates" }
  }
  
  stack {
    // Use a set to track seen numbers
    var $seen { value = {} }
    var $has_duplicate { value = false }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          // Only process if we haven't found a duplicate yet
          if (!$has_duplicate) {
            // Check if we've seen this number before
            conditional {
              if ($seen|has:($num|to_text)) {
                // Found a duplicate
                var $has_duplicate { value = true }
              }
              else {
                // Add number to seen set
                var $seen {
                  value = $seen|set:($num|to_text):true
                }
              }
            }
          }
        }
      }
    }
  }
  
  response = $has_duplicate
}
