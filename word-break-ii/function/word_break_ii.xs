function "word_break_ii" {
  description = "Given a string s and a dictionary of words wordDict, return all possible sentences where each word is a valid dictionary word."

  input {
    text s { description = "The input string to break into words" }
    text[] wordDict { description = "Array of valid dictionary words" }
  }

  stack {
    // Convert wordDict to a set-like object for O(1) lookup
    var $wordSet { value = {} }
    foreach ($input.wordDict) {
      each as $word {
        var $wordSet { value = $wordSet|set:$word:true }
      }
    }

    // Result array to store all valid sentences
    var $result { value = [] }

    // Current path for backtracking (accumulated words)
    var $currentPath { value = [] }

    // Recursive backtracking function using a while loop with manual stack
    // We'll simulate recursion using an explicit stack to avoid function calls within function
    var $stack { value = [{ pos: 0, path: [], index: 0 }] }

    // Since XanoScript doesn't support nested function definitions,
    // we'll use an iterative approach with an explicit stack
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $frame { value = $stack|last }
        var $stack { value = $stack|slice:0:(($stack|count) - 1) }

        var $pos { value = $frame.pos }
        var $path { value = $frame.path }
        var $idx { value = $frame.index }

        // If we've reached the end of the string, we found a valid sentence
        conditional {
          if ($pos == ($input.s|strlen)) {
            var $sentence { value = $path|join:" " }
            var $result { value = $result|push:$sentence }
          }
          else {
            // Try all possible words starting from current position
            // We need to iterate through all possible end positions
            var $maxLen { value = ($input.s|strlen) - $pos }
            var $remaining { value = $input.s|substr:$pos:$maxLen }

            // Try each word in dictionary
            foreach ($input.wordDict) {
              each as $word {
                var $wordLen { value = $word|strlen }
                conditional {
                  if ($wordLen <= $maxLen) {
                    var $substring { value = $input.s|substr:$pos:$wordLen }
                    conditional {
                      if ($substring == $word) {
                        // Found a match, push new frame to stack
                        var $newPath { value = $path|push:$word }
                        var $newFrame { value = { pos: ($pos + $wordLen), path: $newPath, index: 0 } }
                        var $stack { value = $stack|push:$newFrame }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Since the iterative DFS above builds paths in a specific order,
    // let's use a simpler approach: memoization with explicit recursion simulation
    // Actually, let me rewrite with a cleaner approach using a helper stack properly

    // Reset result
    var $result { value = [] }

    // Use a proper iterative DFS with stack storing (position, current_sentence)
    var $dfsStack { value = [{ pos: 0, sentence: "" }] }

    while (($dfsStack|count) > 0) {
      each {
        var $top { value = $dfsStack|last }
        var $dfsStack { value = $dfsStack|pop }

        var $currentPos { value = $top.pos }
        var $currentSentence { value = $top.sentence }

        conditional {
          if ($currentPos == ($input.s|strlen)) {
            // Remove leading space if exists
            conditional {
              if (($currentSentence|strlen) > 0) {
                var $trimmed { value = $currentSentence|substr:1:(($currentSentence|strlen) - 1) }
                var $result { value = $result|push:$trimmed }
              }
            }
          }
          else {
            // Try all words from dictionary
            foreach ($input.wordDict) {
              each as $dictWord {
                var $wordLength { value = $dictWord|strlen }
                var $remainingLen { value = ($input.s|strlen) - $currentPos }

                conditional {
                  if ($wordLength <= $remainingLen) {
                    var $candidate { value = $input.s|substr:$currentPos:$wordLength }
                    conditional {
                      if ($candidate == $dictWord) {
                        var $newSentence { value = $currentSentence ~ " " ~ $dictWord }
                        var $newPos { value = $currentPos + $wordLength }
                        var $dfsStack { value = $dfsStack|push:{ pos: $newPos, sentence: $newSentence } }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  response = $result
}
