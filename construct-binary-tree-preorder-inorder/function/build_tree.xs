// Construct Binary Tree from Preorder and Inorder Traversal
// Builds a binary tree given its preorder and inorder traversal sequences
function "build_tree" {
  description = "Constructs a binary tree from preorder and inorder traversal arrays"

  input {
    int[] preorder { description = "Preorder traversal of the tree (root, left, right)" }
    int[] inorder { description = "Inorder traversal of the tree (left, root, right)" }
  }

  stack {
    // Handle empty input case
    conditional {
      if (($input.preorder|count) == 0) {
        return { value = null }
      }
    }

    // Build a map of value -> index for inorder array for O(1) lookup
    var $inorder_map { value = {} }
    var $idx { value = 0 }
    var $inorder_len { value = $input.inorder|count }

    while ($idx < $inorder_len) {
      each {
        var $val { value = $input.inorder[$idx] }
        var $key { value = $val|to_text }
        var $inorder_map {
          value = $inorder_map|set:$key:$idx
        }
        math.add $idx { value = 1 }
      }
    }

    // Build tree using iterative approach with explicit stack
    // Stack elements track: preStart, preEnd, inStart, inEnd, parent_ref, is_left
    var $stack { value = [] }
    var $root { value = null }

    // Initial call: full ranges, no parent
    var $initial_call {
      value = {
        pre_start: 0,
        pre_end: ($input.preorder|count) - 1,
        in_start: 0,
        in_end: $inorder_len - 1,
        parent: null,
        is_left: true
      }
    }
    array.push $stack { value = $initial_call }

    // Process stack until empty
    while (($stack|count) > 0) {
      each {
        // Pop from stack (get last element)
        var $current { value = $stack|last }
        // Remove last element
        var $new_stack { value = [] }
        var $s_idx { value = 0 }
        var $s_len { value = ($stack|count) - 1 }
        while ($s_idx < $s_len) {
          each {
            array.push $new_stack { value = $stack[$s_idx] }
            math.add $s_idx { value = 1 }
          }
        }
        var $stack { value = $new_stack }

        var $pre_start { value = $current|get:"pre_start" }
        var $pre_end { value = $current|get:"pre_end" }
        var $in_start { value = $current|get:"in_start" }
        var $in_end { value = $current|get:"in_end" }
        var $parent { value = $current|get:"parent" }
        var $is_left { value = $current|get:"is_left" }

        // Get root value from preorder
        var $root_val { value = $input.preorder[$pre_start] }

        // Create node
        var $node {
          value = {
            val: $root_val,
            left: null,
            right: null
          }
        }

        // Link to parent if exists
        conditional {
          if ($parent != null) {
            conditional {
              if ($is_left) {
                var $parent { value = $parent|set:"left":$node }
              }
              else {
                var $parent { value = $parent|set:"right":$node }
              }
            }
          }
          else {
            // This is the root
            var $root { value = $node }
          }
        }

        // Find root position in inorder
        var $root_key { value = $root_val|to_text }
        var $root_in_idx { value = $inorder_map|get:$root_key }

        // Calculate size of left subtree
        var $left_size { value = $root_in_idx - $in_start }

        // Push right child first (so left is processed first - LIFO)
        var $right_pre_start { value = $pre_start + $left_size + 1 }
        conditional {
          if ($right_pre_start <= $pre_end && ($root_in_idx + 1) <= $in_end) {
            var $right_call {
              value = {
                pre_start: $right_pre_start,
                pre_end: $pre_end,
                in_start: $root_in_idx + 1,
                in_end: $in_end,
                parent: $node,
                is_left: false
              }
            }
            array.push $stack { value = $right_call }
          }
        }

        // Push left child
        var $left_pre_end { value = $pre_start + $left_size }
        conditional {
          if (($pre_start + 1) <= $left_pre_end && $in_start <= ($root_in_idx - 1)) {
            var $left_call {
              value = {
                pre_start: $pre_start + 1,
                pre_end: $left_pre_end,
                in_start: $in_start,
                in_end: $root_in_idx - 1,
                parent: $node,
                is_left: true
              }
            }
            array.push $stack { value = $left_call }
          }
        }
      }
    }
  }

  response = $root
}
