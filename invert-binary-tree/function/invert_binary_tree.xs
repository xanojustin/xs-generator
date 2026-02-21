function "invert_binary_tree" {
  description = "Invert a binary tree by swapping left and right children at every node"
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties"
    }
  }
  stack {
    // Base case: if tree is null or empty, return null
    conditional {
      if ($input.tree == null) {
        return { value = null }
      }
    }

    // Get the current node's value
    var $current_val {
      value = $input.tree|get:"val":null
    }

    // Recursively invert the left subtree (it becomes the new right)
    var $left_subtree {
      value = $input.tree|get:"left":null
    }
    var $right_subtree {
      value = $input.tree|get:"right":null
    }

    // Recursively invert left and right subtrees
    var $inverted_left {
      value = null
    }
    var $inverted_right {
      value = null
    }

    // Invert left subtree if it exists
    conditional {
      if ($left_subtree != null) {
        function.run "invert_binary_tree" {
          input = { tree: $left_subtree }
        } as $inverted_left_result
        var.update $inverted_left {
          value = $inverted_left_result
        }
      }
    }

    // Invert right subtree if it exists
    conditional {
      if ($right_subtree != null) {
        function.run "invert_binary_tree" {
          input = { tree: $right_subtree }
        } as $inverted_right_result
        var.update $inverted_right {
          value = $inverted_right_result
        }
      }
    }

    // Build the inverted tree (swap left and right)
    var $inverted_tree {
      value = {
        val: $current_val,
        left: $inverted_right,
        right: $inverted_left
      }
    }
  }
  response = $inverted_tree
}
