// Word Ladder - Classic BFS graph problem
// Find the length of the shortest transformation sequence from beginWord to endWord
// Only one letter can be changed at a time, and each word must exist in the wordList
function "word_ladder" {
  description = "Finds the shortest word ladder transformation length using BFS"
  
  input {
    text begin_word { description = "Starting word" }
    text end_word { description = "Target word" }
    text[] word_list { description = "List of valid words for transformation" }
  }
  
  stack {
    // Edge case: if end_word not in word_list, no valid path
    // Check if end_word is in word_list by iterating
    var $end_found { value = false }
    foreach ($input.word_list) {
      each as $word {
        conditional {
          if ($word == $input.end_word) {
            var $end_found { value = true }
          }
        }
      }
    }
    
    conditional {
      if (!$end_found) {
        return { value = 0 }
      }
    }
    
    // BFS queue: each element is { word: string, steps: int }
    var $queue {
      value = [
        { word: $input.begin_word, steps: 1 }
      ]
    }
    
    // Visited set to avoid cycles - use object with words as keys
    var $visited { value = {} }
    var $visited {
      value = $visited|set:($input.begin_word):true
    }
    
    // Word length for iteration
    var $word_length { value = ($input.begin_word|strlen)|to_int }
    
    // Alphabet array for character substitution
    var $alphabet { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
    
    // BFS loop
    while (($queue|count) > 0) {
      each {
        // Dequeue first element
        var $current { value = $queue|first }
        var $current_word { value = $current|get:"word":"" }
        var $current_steps { value = $current|get:"steps":0 }
        
        // Remove first element from queue
        var $queue { value = $queue|slice:1 }
        
        // Check if we reached the target
        conditional {
          if ($current_word == $input.end_word) {
            return { value = $current_steps }
          }
        }
        
        // Try changing each character
        var $i { value = 0 }
        while ($i < $word_length) {
          each {
            // Iterate through each letter in alphabet
            foreach ($alphabet) {
              each as $letter {
                // Build new word by changing character at position $i
                var $before { value = $current_word|substr:0:$i }
                var $after {
                  value = $current_word|substr:($i + 1)
                }
                var $new_word {
                  value = $before ~ $letter ~ $after
                }
                
                // Check if new_word is in word_list and not visited
                var $is_valid { value = false }
                foreach ($input.word_list) {
                  each as $dict_word {
                    conditional {
                      if ($dict_word == $new_word) {
                        var $is_valid { value = true }
                      }
                    }
                  }
                }
                
                var $visit_check {
                  value = $visited|get:$new_word
                }
                var $is_visited {
                  value = $visit_check ?? false
                }
                
                conditional {
                  if ($is_valid && !$is_visited) {
                    // Mark as visited and enqueue
                    var $visited {
                      value = $visited|set:$new_word:true
                    }
                    var $new_item {
                      value = {
                        word: $new_word,
                        steps: $current_steps + 1
                      }
                    }
                    var $queue {
                      value = $queue|merge:[$new_item]
                    }
                  }
                }
              }
            }
            var $i { value = $i + 1 }
          }
        }
      }
    }
    
    // No path found
    return { value = 0 }
  }
  
  response = 0
}
