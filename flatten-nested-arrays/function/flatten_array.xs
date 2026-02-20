function "flatten_array" {
  description = "Flattens a nested array structure into a single-level array"
  input {
    json nested_array
  }
  stack {
    // Initialize result array
    var $result { value = [] }
    
    // Define recursive helper to process each element
    foreach ($input.nested_array) {
      each as $item {
        // Check if item is an array
        conditional {
          if (`$item|is_array`) {
            // Recursively flatten nested arrays
            function.run "flatten_array" {
              input = { nested_array: $item }
            } as $flattened
            
            // Append flattened results
            foreach ($flattened) {
              each as $subitem {
                var $result { value = $result ~ [$subitem] }
              }
            }
          }
          else {
            // Non-array item, add directly
            var $result { value = $result ~ [$item] }
          }
        }
      }
    }
  }
  response = $result
}
