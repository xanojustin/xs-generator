// Group Anagrams - Classic coding exercise
// Groups anagrams together from an array of strings
// Anagrams are words with the same letters in different orders
function "group_anagrams" {
  description = "Groups anagrams together from an array of strings"
  
  input {
    text[] strings { description = "Array of strings to group" }
  }
  
  stack {
    // Handle empty input
    conditional {
      if (($input.strings|count) == 0) {
        return { value = [] }
      }
    }
    
    // Create array of objects with word and signature
    var $tagged_words { value = [] }
    var $i { value = 0 }
    
    while ($i < $input.strings|count) {
      each {
        var $word { value = $input.strings[$i] }
        
        // Create signature by sorting characters
        var $chars { value = $word|split:"" }
        var $sorted_chars { value = $chars|sort }
        var $signature { value = $sorted_chars|join:"" }
        
        // Add to tagged words
        var $tagged { 
          value = $tagged_words|merge:[{word: $word, signature: $signature}]
        }
        var $tagged_words { value = $tagged }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Group by signature using index_by
    var $grouped { value = $tagged_words|index_by:"signature" }
    
    // Extract just the words from each group
    var $result { value = [] }
    var $keys { value = $grouped|keys }
    var $k { value = 0 }
    
    while ($k < $keys|count) {
      each {
        var $key { value = $keys[$k] }
        var $group_items { value = $grouped[$key] }
        
        // Extract just the words from this group
        var $words_only { value = $group_items|map:$$.word }
        var $result { value = $result|merge:[$words_only] }
        
        var.update $k { value = $k + 1 }
      }
    }
  }
  
  response = $result
}
