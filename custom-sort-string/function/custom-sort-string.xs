function "custom-sort-string" {
  description = "Sort characters in string s based on custom order defined in order string"
  input {
    text order { description = "Custom order string with unique characters" }
    text s { description = "String to be sorted" }
  }
  stack {
    // Create a map of character to its position in the custom order
    var $char_order { value = {} }
    var $order_len { value = $input.order|strlen }
    var $i { value = 0 }
    
    for ($order_len) {
      each as $idx {
        var $char { value = $input.order|substr:$idx:1 }
        var $char_order { value = $char_order|set:$char:$idx }
      }
    }
    
    // Separate characters in s into those in order and those not in order
    var $in_order { value = [] }
    var $not_in_order { value = [] }
    var $s_len { value = $input.s|strlen }
    
    for ($s_len) {
      each as $idx {
        var $char { value = $input.s|substr:$idx:1 }
        conditional {
          if ($char_order|has:$char) {
            var $in_order { 
              value = $in_order|push:{
                char: $char,
                order: ($char_order|get:$char)
              }
            }
          }
          else {
            var $not_in_order { value = $not_in_order|push:$char }
          }
        }
      }
    }
    
    // Sort characters that are in the custom order
    var $sorted_in_order {
      value = $in_order|sort:"order"
    }
    
    // Build result string from sorted characters
    var $result { value = "" }
    foreach ($sorted_in_order) {
      each as $item {
        var $result { value = $result ~ ($item|get:"char") }
      }
    }
    
    // Append characters not in custom order
    foreach ($not_in_order) {
      each as $char {
        var $result { value = $result ~ $char }
      }
    }
  }
  response = $result
}
