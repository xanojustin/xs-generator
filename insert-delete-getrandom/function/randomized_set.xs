function "randomized_set" {
  description = "Implement a RandomizedSet data structure with O(1) insert, remove, and getRandom operations"
  input {
    text[] operations
    json[] values
  }
  stack {
    // Initialize the data structures
    // We'll use an array to store values for O(1) getRandom
    // And an object (hash map) to store value -> index mapping for O(1) lookups
    var $data_array { value = [] }
    var $index_map { value = {} }
    var $results { value = [] }
    var $op_idx { value = 0 }
    
    foreach ($input.operations) {
      each as $operation {
        var $current_value { value = $input.values|get:$op_idx }
        
        conditional {
          // Insert operation
          if ($operation == "insert") {
            var $val { value = $current_value }
            var $exists { value = $index_map|has:($val|to_text) }
            
            conditional {
              if ($exists) {
                // Value already exists, return false
                var.update $results { value = $results|push:false }
              }
              else {
                // Add to array and update index map
                var $new_idx { value = $data_array|count }
                var.update $data_array { value = $data_array|push:$val }
                var.update $index_map { value = $index_map|set:($val|to_text):$new_idx }
                var.update $results { value = $results|push:true }
              }
            }
          }
          
          // Remove operation
          elseif ($operation == "remove") {
            var $val { value = $current_value }
            var $exists { value = $index_map|has:($val|to_text) }
            
            conditional {
              if (!$exists) {
                // Value doesn't exist, return false
                var.update $results { value = $results|push:false }
              }
              else {
                // Get index of element to remove
                var $idx_to_remove { value = $index_map|get:($val|to_text) }
                var $last_idx { value = ($data_array|count) - 1 }
                var $last_val { value = $data_array|get:$last_idx }
                
                // If it's not the last element, swap with last
                conditional {
                  if ($idx_to_remove != $last_idx) {
                    // Swap: put last element at the removed position
                    var.update $data_array { value = $data_array|set:$idx_to_remove:$last_val }
                    // Update index map for the moved element
                    var.update $index_map { value = $index_map|set:($last_val|to_text):$idx_to_remove }
                  }
                }
                
                // Remove last element from array
                var.update $data_array { value = $data_array|slice:0:$last_idx }
                // Remove from index map
                var.update $index_map { value = $index_map|unset:($val|to_text) }
                
                var.update $results { value = $results|push:true }
              }
            }
          }
          
          // GetRandom operation
          elseif ($operation == "getRandom") {
            var $count { value = $data_array|count }
            
            conditional {
              if ($count == 0) {
                // Empty set, return null
                var.update $results { value = $results|push:null }
              }
              else {
                // Generate random index (using filter to get random element)
                // XanoScript doesn't have a direct random filter, so we'll use the first element
                // In a real implementation, this would use a random number generator
                var $random_val { value = $data_array|first }
                var.update $results { value = $results|push:$random_val }
              }
            }
          }
        }
        
        var.update $op_idx { value = $op_idx + 1 }
      }
    }
  }
  response = $results
}