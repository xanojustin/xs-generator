function "substring_concatenation" {
  description = "Find all starting indices of substrings that are a concatenation of all given words"
  input {
    text s { description = "The string to search in" }
    text[] words { description = "Array of words (all same length) to find concatenations of" }
  }
  stack {
    var $result { value = [] }
    
    // Edge cases
    conditional {
      if (($input.words|count) == 0 || ($input.s|count) == 0) {
        return { value = [] }
      }
    }
    
    // Get word length and total words
    var $word_len { value = ($input.words|first)|count }
    var $num_words { value = $input.words|count }
    var $total_len { value = $word_len * $num_words }
    var $str_len { value = $input.s|count }
    
    // Build word count map from input words
    var $word_count { value = {} }
    foreach ($input.words) {
      each as $word {
        conditional {
          if ($word_count|get:$word:false) {
            var $current_count { value = ($word_count|get:$word) + 1 }
            var.update $word_count { value = $word_count|set:$word:$current_count }
          }
          else {
            var.update $word_count { value = $word_count|set:$word:1 }
          }
        }
      }
    }
    
    // Slide window over string
    var $i { value = 0 }
    while ($i <= $str_len - $total_len) {
      each {
        var $seen { value = {} }
        var $j { value = 0 }
        var $valid { value = true }
        
        while ($j < $num_words && $valid) {
          each {
            // Extract word at current position
            var $start_idx { value = $i + ($j * $word_len) }
            var $end_idx { value = $start_idx + $word_len }
            var $current_word { value = $input.s|slice:$start_idx:$end_idx }
            
            // Check if word is in our word list
            conditional {
              if (!($word_count|get:$current_word:false)) {
                var.update $valid { value = false }
              }
              else {
                // Update seen count
                conditional {
                  if ($seen|get:$current_word:false) {
                    var $new_count { value = ($seen|get:$current_word) + 1 }
                    var.update $seen { value = $seen|set:$current_word:$new_count }
                  }
                  else {
                    var.update $seen { value = $seen|set:$current_word:1 }
                  }
                }
                
                // Check if we've seen this word too many times
                conditional {
                  if (($seen|get:$current_word) > ($word_count|get:$current_word)) {
                    var.update $valid { value = false }
                  }
                }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        // If valid, add starting index
        conditional {
          if ($valid && $j == $num_words) {
            var.update $result { value = $result|push:$i }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
