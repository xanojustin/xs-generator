function "build_bst_helper" {
  description = "Recursively build balanced BST from sorted array"
  input {
    int[] values
    int start
    int end
  }
  stack {
    conditional {
      if ($input.start > $input.end) {
        return { value = null }
      }
    }

    // Find middle element for root
    var $mid { value = ($input.start + $input.end) / 2 }

    // Get left subtree
    function.run "build_bst_helper" {
      input = {
        values: $input.values
        start: $input.start
        end: $mid - 1
      }
    } as $left

    // Get right subtree
    function.run "build_bst_helper" {
      input = {
        values: $input.values
        start: $mid + 1
        end: $input.end
      }
    } as $right

    // Create root node
    var $root {
      value = {
        val: $input.values|get:$mid
        left: $left
        right: $right
      }
    }
  }
  response = $root
}
