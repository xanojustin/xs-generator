// Partition List - Linked list partitioning exercise
// Given a linked list (represented as array) and a value x,
// partition it such that all nodes less than x come before
// nodes greater than or equal to x, preserving relative order
function "partition_list" {
  description = "Partitions a linked list around value x"

  input {
    int[] head { description = "Linked list represented as array of integers" }
    int x { description = "Partition value - nodes < x go before nodes >= x" }
  }

  stack {
    // Two lists to hold partitioned elements
    var $less { value = [] }
    var $greater_or_equal { value = [] }
    var $i { value = 0 }

    // Iterate through the input list
    while ($i < ($input.head|count)) {
      each {
        var $current { value = $input.head[$i] }

        conditional {
          if ($current < $input.x) {
            var $less { value = $less|merge:[$current] }
          }
          else {
            var $greater_or_equal { value = $greater_or_equal|merge:[$current] }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Concatenate less list with greater-or-equal list
    var $result { value = $less|merge:$greater_or_equal }
  }

  response = $result
}
