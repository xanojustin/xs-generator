function "longest_word" {
  description = "Find the longest word that can be built one character at a time by other words in the dictionary"
  input {
    text[] words { description = "Array of words/strings to search through" }
  }
  stack {
    // Create a set (object with words as keys) for O(1) lookup
    var $word_set { value = {} }
    foreach ($input.words) {
      each as $word {
        var.update $word_set { value = $word_set|set:$word:true }
      }
    }
    
    // Find the maximum length of any word
    var $max_length { value = 0 }
    foreach ($input.words) {
      each as $word {
        var $word_len { value = $word|strlen }
        conditional {
          if ($word_len > $max_length) {
            var.update $max_length { value = $word_len }
          }
        }
      }
    }
    
    // Variable to track the result
    var $result { value = "" }
    
    // Process words from longest to shortest length
    // For each length level, check all words of that length
    for ($max_length) {
      each as $length_idx {
        // Calculate actual length we're checking (descending: max, max-1, max-2, ...)
        var $current_length { value = $max_length - $length_idx + 1 }
        
        // Collect all words with current_length
        var $words_at_length { value = [] }
        foreach ($input.words) {
          each as $word {
            conditional {
              if (($word|strlen) == $current_length) {
                var.update $words_at_length { value = $words_at_length|push:$word }
              }
            }
          }
        }
        
        // Sort words at this length lexicographically to get smallest first
        var $sorted_words { value = $words_at_length|sort }
        
        // Check each word to see if it can be built
        foreach ($sorted_words) {
          each as $word {
            // Check if all prefixes exist in the dictionary
            var $can_build { value = true }
            var $prefix { value = "" }
            
            // Iterate through each character to build prefixes
            var $chars { value = $word|split:"" }
            
            foreach ($chars) {
              each as $char {
                var.update $prefix { value = $prefix ~ $char }
                
                // Check if this prefix exists in the word set
                conditional {
                  if ($word_set|has:$prefix == false) {
                    var.update $can_build { value = false }
                    break
                  }
                }
              }
            }
            
            // If this word can be built, we found our answer
            // (since we're going longest-first, then lexicographically)
            conditional {
              if ($can_build == true) {
                // If same length, pick lexicographically smaller
                conditional {
                  if ($result == "") {
                    var.update $result { value = $word }
                  }
                  elseif ($word < $result) {
                    var.update $result { value = $word }
                  }
                }
              }
            }
          }
        }
        
        // If we found a result at this length, we can stop
        // (since we're checking from longest to shortest)
        conditional {
          if ($result != "") {
            // Only stop if we've checked all words at this max length
            // Continue to find lexicographically smallest at max length
          }
        }
      }
    }
  }
  response = $result
}
