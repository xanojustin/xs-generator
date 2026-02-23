// Add Two Numbers
// You are given two non-empty linked lists representing two non-negative integers.
// The digits are stored in reverse order, and each node contains a single digit.
// Add the two numbers and return the sum as a linked list.
// You may assume the two numbers do not contain any leading zero, except the number 0 itself.
function "add_two_numbers" {
  description = "Add two numbers represented as linked lists"
  
  input {
    json l1
    json l2
    int? head1?=0
    int? head2?=0
  }
  
  stack {
    var $result {
      value = []
    }
    var $index1 {
      value = $input.head1
    }
    var $index2 {
      value = $input.head2
    }
    var $carry {
      value = 0
    }
    var $result_index {
      value = 0
    }

    // Continue while there are digits in either list or there's a carry
    while (($index1 != null) || ($index2 != null) || ($carry > 0)) {
      each {
        var $sum {
          value = $carry
        }

        // Add digit from first list if available
        conditional {
          if ($index1 != null) {
            var $digit1 {
              value = $input.l1[$index1]|get:"value"
            }
            math.add $sum {
              value = $digit1
            }
            var $next1 {
              value = $input.l1[$index1]|get:"next"
            }
            var $index1 {
              value = $next1
            }
          }
        }

        // Add digit from second list if available
        conditional {
          if ($index2 != null) {
            var $digit2 {
              value = $input.l2[$index2]|get:"value"
            }
            math.add $sum {
              value = $digit2
            }
            var $next2 {
              value = $input.l2[$index2]|get:"next"
            }
            var $index2 {
              value = $next2
            }
          }
        }

        // Calculate new digit and carry
        var $new_digit {
          value = $sum % 10
        }
        var $new_carry {
          value = $sum / 10
        }
        var $carry {
          value = $new_carry
        }

        // Determine if there will be more nodes
        var $has_more {
          value = false
        }
        conditional {
          if (($index1 != null) || ($index2 != null) || ($carry > 0)) {
            var $has_more {
              value = true
            }
          }
        }

        // Create new node for result
        var $next_index {
          value = null
        }
        conditional {
          if ($has_more == true) {
            var $next_val {
              value = $result_index + 1
            }
            var $next_index {
              value = $next_val
            }
          }
        }

        var $new_node {
          value = { value: $new_digit, next: $next_index }
        }

        // Add node to result list
        array.push $result {
          value = $new_node
        }

        math.add $result_index {
          value = 1
        }
      }
    }
  }
  
  response = $result
}
