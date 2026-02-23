function "simplify_path" {
  description = "Simplify a Unix-style file path to its canonical form"
  input {
    text path filters=trim { description = "Absolute path starting with /" }
  }
  stack {
    // Split the path by '/' delimiter
    var $parts { value = $input.path|split:"/" }
    
    // Stack to hold valid directory names
    var $stack { value = [] }
    
    // Process each part
    foreach ($parts) {
      each as $part {
        conditional {
          // Skip empty parts (from consecutive slashes) and current directory "."
          if ($part == "" || $part == ".") {
            continue
          }
          // Go up one directory for ".."
          elseif ($part == "..") {
            conditional {
              if (($stack|count) > 0) {
                array.pop $stack as $popped
              }
            }
          }
          // Valid directory name - add to stack
          else {
            array.push $stack {
              value = $part
            }
          }
        }
      }
    }
    
    // Build the canonical path
    var $result { value = "/" }
    
    conditional {
      if (($stack|count) > 0) {
        // Join stack elements with "/"
        var $canonical { value = $stack|join:"/" }
        var.update $result { value = "/" ~ $canonical }
      }
    }
  }
  response = $result
}
