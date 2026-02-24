// Assign Cookies - Greedy algorithm exercise
// Find the maximum number of children that can be satisfied with given cookies
function "assign_cookies" {
  description = "Maximize the number of satisfied children by assigning cookies optimally"

  input {
    int[] greed_factors { description = "Greed factor of each child (minimum cookie size needed)" }
    int[] cookie_sizes { description = "Size of each available cookie" }
  }

  stack {
    // Sort both arrays to use greedy approach
    var $sorted_greed { value = $input.greed_factors|sort }
    var $sorted_cookies { value = $input.cookie_sizes|sort }

    // Initialize pointers and count
    var $child_idx { value = 0 }
    var $cookie_idx { value = 0 }
    var $satisfied { value = 0 }
    var $num_children { value = $sorted_greed|count }
    var $num_cookies { value = $sorted_cookies|count }

    // Greedy: assign smallest sufficient cookie to each child
    while ($child_idx < $num_children && $cookie_idx < $num_cookies) {
      each {
        conditional {
          // If current cookie can satisfy current child
          if ($sorted_cookies[$cookie_idx] >= $sorted_greed[$child_idx]) {
            // Assign cookie to child
            var $satisfied { value = $satisfied + 1 }
            var $child_idx { value = $child_idx + 1 }
            var $cookie_idx { value = $cookie_idx + 1 }
          }
          else {
            // Cookie too small, try next cookie
            var $cookie_idx { value = $cookie_idx + 1 }
          }
        }
      }
    }
  }

  response = $satisfied
}
