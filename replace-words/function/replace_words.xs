function "replace_words" {
  description = "Replace words in a sentence with their shortest root from a dictionary"
  input {
    text[] dictionary { description = "List of root words" }
    text sentence { description = "Sentence to process" }
  }
  stack {
    // Split the sentence into words
    var $words { value = $input.sentence|split:" " }
    
    // Sort dictionary by length (shortest first) so we find shortest root
    var $sorted_dict {
      value = $input.dictionary|sort:$$|strlen
    }
    
    // Process each word and find its replacement
    var $result_words { value = [] }
    
    foreach ($words) {
      each as $word {
        var $replacement { value = $word }
        var $found { value = false }
        
        // Check each root in dictionary (shortest first)
        foreach ($sorted_dict) {
          each as $root {
            conditional {
              if (!$found) {
                // Check if word starts with this root
                var $root_len { value = $root|strlen }
                var $word_prefix {
                  value = $word|substr:0:$root_len
                }
                
                conditional {
                  if ($word_prefix == $root) {
                    var.update $replacement { value = $root }
                    var.update $found { value = true }
                  }
                }
              }
            }
          }
        }
        
        // Add replacement to result
        var.update $result_words {
          value = $result_words|merge:[$replacement]
        }
      }
    }
    
    // Join words back into sentence
    var $result {
      value = $result_words|join:" "
    }
  }
  response = $result
}
