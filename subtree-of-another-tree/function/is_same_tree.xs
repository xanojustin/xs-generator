function "is_same_tree" {
  description = "Helper function to check if two binary trees are identical (same structure and values)"
  input {
    json tree1 {
      description = "First binary tree node with val, left, and right properties"
    }
    json tree2 {
      description = "Second binary tree node with val, left, and right properties"
    }
  }
  stack {
    // Both null - identical
    conditional {
      if ($input.tree1 == null && $input.tree2 == null) {
        return { value = true }
      }
    }

    // One null, one not - not identical
    conditional {
      if ($input.tree1 == null || $input.tree2 == null) {
        return { value = false }
      }
    }

    // Get values
    var $val1 {
      value = $input.tree1|get:"val":null
    }
    var $val2 {
      value = $input.tree2|get:"val":null
    }

    // Values don't match - not identical
    conditional {
      if ($val1 != $val2) {
        return { value = false }
      }
    }

    // Get subtrees
    var $left1 {
      value = $input.tree1|get:"left":null
    }
    var $right1 {
      value = $input.tree1|get:"right":null
    }
    var $left2 {
      value = $input.tree2|get:"left":null
    }
    var $right2 {
      value = $input.tree2|get:"right":null
    }

    // Recursively check left and right subtrees
    var $left_same {
      value = false
    }
    var $right_same {
      value = false
    }

    // Check left subtrees
    conditional {
      if ($left1 == null && $left2 == null) {
        var.update $left_same { value = true }
      }
      elseif ($left1 != null && $left2 != null) {
        function.run "is_same_tree" {
          input = { tree1: $left1, tree2: $left2 }
        } as $left_result
        var.update $left_same { value = $left_result }
      }
      else {
        var.update $left_same { value = false }
      }
    }

    // Check right subtrees
    conditional {
      if ($right1 == null && $right2 == null) {
        var.update $right_same { value = true }
      }
      elseif ($right1 != null && $right2 != null) {
        function.run "is_same_tree" {
          input = { tree1: $right1, tree2: $right2 }
        } as $right_result
        var.update $right_same { value = $right_result }
      }
      else {
        var.update $right_same { value = false }
      }
    }

    var $result {
      value = $left_same && $right_same
    }
  }
  response = $result
}
