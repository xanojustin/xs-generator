function "shortest_palindrome" {
  description = "Find the shortest palindrome by adding characters to the front of a string"
  input {
    text s { description = "Input string to convert to palindrome" }
  }
  stack {
    // Handle empty string edge case
    conditional {
      if (($input.s|strlen) == 0) {
        return { value = "" }
      }
    }
    
    // Get string length
    var $len { value = $input.s|strlen }
    
    // Reverse the string to compare
    var $reversed { value = ($input.s|split:"")|reverse|join:"" }
    
    // Find the longest palindromic prefix by comparing s with reverse
    // We need to find where the prefix of s matches suffix of reversed
    var $longest_prefix { value = 0 }
    
    // Try each possible prefix length
    var $i { value = 0 }
    while ($i < $len) {
      each {
        // Get prefix of original string (0 to i+1)
        var $prefix { value = $input.s|substr:0:($i + 1) }
        
        // Get suffix of reversed string (len-i-1 to end)
        var $suffix_start { value = $len - $i - 1 }
        var $suffix { value = $reversed|substr:$suffix_start:$len }
        
        // Check if they match
        conditional {
          if ($prefix == $suffix) {
            var.update $longest_prefix { value = $i + 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // The non-palindromic suffix is from longest_prefix to end
    var $suffix_to_add { value = $input.s|substr:$longest_prefix:$len }
    
    // Reverse it and prepend to original
    var $result { value = (($suffix_to_add|split:"")|reverse|join:"") ~ $input.s }
  }
  response = $result
}
