function "flatten_nested_arrays" {
  description = "Flatten a nested array structure into a single-level array"
  input {
    json nested_array {
      description = "An array that may contain nested arrays at any depth"
    }
  }
  stack {
    var $result { value = [] }
    var $stack { value = $input.nested_array }
    
    while (($stack|count) > 0) {
      each {
        var $item { value = $stack|first }
        var $stack {
          value = $stack|slice:1
        }
        
        conditional {
          if ($item|is_array) {
            // Item is an array - push its elements onto the stack
            var $item_array { value = $item }
            var $item_index { value = ($item_array|count) - 1 }
            
            while ($item_index >= 0) {
              each {
                var $stack {
                  value = $stack|unshift:($item_array|get:$item_index)
                }
                var.update $item_index { value = $item_index - 1 }
              }
            }
          }
          else {
            // Item is a scalar - add to result
            var $result {
              value = $result|push:$item
            }
          }
        }
      }
    }
  }
  response = $result
}
