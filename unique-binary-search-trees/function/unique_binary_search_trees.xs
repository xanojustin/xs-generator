function "unique_binary_search_trees" {
  description = "Count the number of structurally unique BSTs with n nodes"
  input {
    int n filters=min:0 { description = "Number of nodes (0 to n)" }
  }
  stack {
    // Base cases: 0 nodes = 1 way (empty tree), 1 node = 1 way
    conditional {
      if ($input.n <= 1) {
        return { value = 1 }
      }
    }

    // dp[i] represents the number of unique BSTs with i nodes
    // dp[0] = 1, dp[1] = 1
    var $dp {
      value = [1, 1]
    }

    // Build up the solution using Catalan number recurrence
    // G(n) = sum of G(i-1) * G(n-i) for i from 1 to n
    // For each possible root i, left subtree has i-1 nodes, right has n-i nodes
    for ($input.n - 1) {
      each as $i {
        // Calculate dp[i + 1] (we're building up from 2 to n)
        var $current_size { value = $i + 2 }
        var $count { value = 0 }

        // Try each possible root from 1 to current_size
        for ($current_size) {
          each as $j {
            // root is at position j+1 (1-indexed)
            // left subtree has j nodes, right has (current_size - j - 1) nodes
            var $left_count {
              value = $dp|get:($j)|to_int:0
            }
            var $right_idx {
              value = ($current_size - $j - 1)|to_int
            }
            var $right_count {
              value = $dp|get:$right_idx|to_int:0
            }
            var $product {
              value = $left_count * $right_count
            }
            var.update $count {
              value = $count + $product
            }
          }
        }

        // Append the computed count to dp array
        var.update $dp {
          value = $dp|append:$count
        }
      }
    }

    // Return the result for n nodes
    var $result {
      value = $dp|get:$input.n|to_int
    }
  }
  response = $result
}
