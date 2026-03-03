function "remove_adjacent_duplicates" {
  description = "Remove all adjacent duplicate characters from a string using a stack"
  
  input {
    text s { description = "Input string of lowercase letters" }
  }
  
  stack {
    // Initialize an empty stack (array)
    var $stack { value = [] }
    
    // Split the string into individual characters
    var $chars { value = $input.s|split:"" }
    
    // Iterate through each character
    foreach ($chars) {
      each as $char {
        // Check if stack is not empty and top of stack equals current char
        conditional {
          if (($stack|count) > 0 && ($stack|last) == $char) {
            // Pop the stack - remove the last element (adjacent duplicate found)
            var $new_stack { value = $stack|slice:0:-1 }
            var.update $stack { value = $new_stack }
          }
          else {
            // Push the character onto the stack
            var $new_stack { value = $stack|push:$char }
            var.update $stack { value = $new_stack }
          }
        }
      }
    }
    
    // Join the stack to form the final string
    var $result { value = $stack|join:"" }
  }
  
  response = $result
}
