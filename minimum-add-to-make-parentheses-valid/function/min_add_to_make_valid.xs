// Minimum Add to Make Parentheses Valid
// Given a string of '(' and ')', find the minimum number of parentheses 
// to add to make the string valid (balanced)
function "min_add_to_make_valid" {
  description = "Returns the minimum number of parentheses to add for a valid string"

  input {
    text s { description = "String containing only '(' and ')' characters" }
  }

  stack {
    // Track unmatched open parentheses
    var $open_count { value = 0 }
    // Track needed additions for unmatched closing parentheses
    var $additions_needed { value = 0 }
    // Index for iteration
    var $i { value = 0 }
    // Convert string to array of characters
    var $chars { value = $input.s|split:"" }

    while ($i < ($chars|count)) {
      each {
        var $char { value = $chars[$i] }

        conditional {
          // Opening parenthesis - increment open count
          if ($char == "(") {
            var $open_count { value = $open_count + 1 }
          }
          // Closing parenthesis
          elseif ($char == ")") {
            conditional {
              // If we have unmatched opens, match one
              if ($open_count > 0) {
                var $open_count { value = $open_count - 1 }
              }
              // No unmatched opens, need to add an open paren before this
              else {
                var $additions_needed { value = $additions_needed + 1 }
              }
            }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Total additions: unmatched closes we added opens for + unmatched opens needing closes
    var $total_additions { value = $additions_needed + $open_count }
  }

  response = $total_additions
}
