// Reverse Vowels - Reverse only the vowels in a string
// Vowels are: a, e, i, o, u (both uppercase and lowercase)
function "reverse_vowels" {
  description = "Reverses only the vowels in a string while keeping consonants in place"
  
  input {
    text s { description = "Input string to process" }
  }
  
  stack {
    // Define vowels
    var $vowels { value = "aeiouAEIOU" }
    
    // Convert string to array of characters
    var $chars { value = $input.s|split:"" }
    
    // Collect indices and values of vowels
    var $vowel_indices { value = [] }
    var $vowel_values { value = [] }
    var $i { value = 0 }
    
    while ($i < ($chars|count)) {
      each {
        var $char { value = $chars[$i] }
        var $is_vowel { value = $vowels|contains:$char }
        
        conditional {
          if ($is_vowel) {
            var $vowel_indices { value = $vowel_indices|merge:[$i] }
            var $vowel_values { value = $vowel_values|merge:[$char] }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reverse the vowel values
    var $reversed_vowels { value = $vowel_values|reverse }
    
    // Place reversed vowels back at their original indices
    // Build new array by slicing and merging
    var $j { value = 0 }
    while ($j < ($vowel_indices|count)) {
      each {
        var $idx { value = $vowel_indices[$j] }
        var $new_vowel { value = $reversed_vowels[$j] }
        
        // Slice before index, add new vowel, slice after index
        var $before { value = $chars|slice:0:$idx }
        var $after { value = $chars|slice:($idx + 1):($chars|count) }
        var $chars { value = $before|merge:[$new_vowel]|merge:$after }
        
        var.update $j { value = $j + 1 }
      }
    }
    
    // Join array back into string
    var $result { value = $chars|join:"" }
  }
  
  response = $result
}
