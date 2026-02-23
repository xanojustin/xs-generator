// Longest Valid Parentheses - Classic hard stack problem
// Given a string containing just '(' and ')', find the length of the longest
// valid (well-formed) parentheses substring.
// Uses a stack to track indices for O(n) time complexity
function "longest_valid_parentheses" {
  description = "Finds the length of the longest valid parentheses substring"

  input {
    text s { description = "String containing only '(' and ')' characters" }
  }

  stack {
    // Stack to store indices of parentheses
    // Initialize with -1 as a base for calculating lengths
    var $stack { value = [-1] }
    var $max_length { value = 0 }
    var $i { value = 0 }
    var $chars { value = $input.s|split:"" }
    var $length { value = $chars|count }

    while ($i < $length) {
      each {
        var $char { value = $chars[$i] }

        conditional {
          // Opening parenthesis: push its index onto stack
          if ($char == "(") {
            var $stack { value = $stack|merge:[$i] }
          }
          // Closing parenthesis
          else {
            // Pop the top element - create new array without last element
            var $new_stack { value = [] }
            var $j { value = 0 }
            while ($j < (($stack|count) - 1)) {
              each {
                var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                var.update $j { value = $j + 1 }
              }
            }
            var $stack { value = $new_stack }

            // If stack is empty after pop, push current index as new base
            conditional {
              if (($stack|count) == 0) {
                var $stack { value = $stack|merge:[$i] }
              }
              // Otherwise calculate length and update max
              else {
                var $top { value = $stack|last }
                var $current_length { value = $i - $top }
                conditional {
                  if ($current_length > $max_length) {
                    var $max_length { value = $current_length }
                  }
                }
              }
            }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $max_length
}
