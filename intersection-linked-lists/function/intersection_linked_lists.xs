// Intersection of Two Linked Lists
// Given two singly linked lists (array representation), find the intersection node.
// Uses the two-pointer technique with length calculation for O(n) time and O(1) space.
function "intersection_linked_lists" {
  description = "Finds the intersection node of two linked lists"

  input {
    object[] list_a {
      description = "First linked list as array of nodes"
      schema {
        int val { description = "Node value" }
        int? next { description = "Index of next node, null if end" }
      }
    }
    int head_a {
      description = "Index of head node in list_a"
    }
    object[] list_b {
      description = "Second linked list as array of nodes"
      schema {
        int val { description = "Node value" }
        int? next { description = "Index of next node, null if end" }
      }
    }
    int head_b {
      description = "Index of head node in list_b"
    }
  }

  stack {
    // Calculate length of list A
    var $len_a { value = 0 }
    var $current { value = $input.head_a }

    while ($current != null) {
      each {
        var.update $len_a { value = $len_a + 1 }
        var $current {
          value = $input.list_a[$current]|get:"next"
        }
      }
    }

    // Calculate length of list B
    var $len_b { value = 0 }
    var $current { value = $input.head_b }

    while ($current != null) {
      each {
        var.update $len_b { value = $len_b + 1 }
        var $current {
          value = $input.list_b[$current]|get:"next"
        }
      }
    }

    // Set up pointers at head of each list
    var $ptr_a { value = $input.head_a }
    var $ptr_b { value = $input.head_b }

    // Advance the pointer of the longer list by the difference
    conditional {
      if ($len_a > $len_b) {
        var $diff { value = $len_a - $len_b }
        var $i { value = 0 }
        while ($i < $diff) {
          each {
            var $ptr_a {
              value = $input.list_a[$ptr_a]|get:"next"
            }
            var.update $i { value = $i + 1 }
          }
        }
      }
      elseif ($len_b > $len_a) {
        var $diff { value = $len_b - $len_a }
        var $i { value = 0 }
        while ($i < $diff) {
          each {
            var $ptr_b {
              value = $input.list_b[$ptr_b]|get:"next"
            }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }

    // Move both pointers together until they meet or reach end
    var $intersection_idx { value = null }

    while ($ptr_a != null && $ptr_b != null) {
      each {
        // Check if we're at the same node (same index means same node in this representation)
        conditional {
          if ($ptr_a == $ptr_b) {
            var $intersection_idx { value = $ptr_a }
            return { value = $intersection_idx }
          }
        }
        var $ptr_a {
          value = $input.list_a[$ptr_a]|get:"next"
        }
        var $ptr_b {
          value = $input.list_b[$ptr_b]|get:"next"
        }
      }
    }
  }

  response = $intersection_idx
}
