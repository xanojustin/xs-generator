function "find_mode_in_bst" {
  description = "Find the mode(s) (most frequently occurring element) in a Binary Search Tree"
  input {
    json root {
      description = "Root node of the binary search tree (object with val, left, right)"
    }
  }
  stack {
    // Handle empty tree
    conditional {
      if ($input.root == null || $input.root|has:"val" == false) {
        return { value = [] }
      }
    }
    
    // Initialize variables for in-order traversal
    var $frequency_map { value = {} }
    var $max_count { value = 0 }
    var $stack { value = [] }
    var $current { value = $input.root }
    
    // Iterative in-order traversal of BST
    while (($current != null) || (($stack|count) > 0)) {
      each {
        // Go to leftmost node
        while ($current != null) {
          each {
            var.update $stack { value = $stack|append:$current }
            var.update $current { value = $current|get:"left":null }
          }
        }
        
        // Process current node
        var $node { value = $stack|last }
        var.update $stack { value = $stack|slice:0:(-1) }
        
        var $node_val { value = $node|get:"val":0 }
        var $current_count { value = ($frequency_map|get:($node_val|to_text):0) + 1 }
        var.update $frequency_map { value = $frequency_map|set:($node_val|to_text):$current_count }
        
        // Update max count
        conditional {
          if ($current_count > $max_count) {
            var.update $max_count { value = $current_count }
          }
        }
        
        // Move to right subtree
        var.update $current { value = $node|get:"right":null }
      }
    }
    
    // Collect all values with max frequency
    var $result { value = [] }
    var $keys { value = $frequency_map|keys }
    
    foreach ($keys) {
      each as $key {
        var $count { value = $frequency_map|get:$key:0 }
        conditional {
          if ($count == $max_count) {
            var.update $result { value = $result|append:($key|to_int) }
          }
        }
      }
    }
  }
  response = $result
}
