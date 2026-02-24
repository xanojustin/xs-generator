function "is_subtree" {
  description = "Check if subRoot is a subtree of root (subRoot has same structure and node values as some subtree of root)"
  input {
    json root {
      description = "Main binary tree node with val, left, and right properties"
    }
    json subRoot {
      description = "Subtree candidate to search for within root"
    }
  }
  stack {
    // Base case: empty subRoot is a subtree of any tree
    conditional {
      if ($input.subRoot == null) {
        return { value = true }
      }
    }

    // Base case: non-empty subRoot can't be subtree of empty root
    conditional {
      if ($input.root == null) {
        return { value = false }
      }
    }

    // Check if current trees are identical
    function.run "is_same_tree" {
      input = { tree1: $input.root, tree2: $input.subRoot }
    } as $is_identical

    conditional {
      if ($is_identical == true) {
        return { value = true }
      }
    }

    // Get left and right subtrees of root
    var $left_root {
      value = $input.root|get:"left":null
    }
    var $right_root {
      value = $input.root|get:"right":null
    }

    // Recursively check left subtree
    var $found_in_left {
      value = false
    }
    conditional {
      if ($left_root != null) {
        function.run "is_subtree" {
          input = { root: $left_root, subRoot: $input.subRoot }
        } as $left_result
        var.update $found_in_left { value = $left_result }
      }
    }

    conditional {
      if ($found_in_left == true) {
        return { value = true }
      }
    }

    // Recursively check right subtree
    var $found_in_right {
      value = false
    }
    conditional {
      if ($right_root != null) {
        function.run "is_subtree" {
          input = { root: $right_root, subRoot: $input.subRoot }
        } as $right_result
        var.update $found_in_right { value = $right_result }
      }
    }

    var $result {
      value = $found_in_right
    }
  }
  response = $result
}
