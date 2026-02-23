function "sorted_array_to_bst" {
  description = "Convert a sorted array to a height-balanced binary search tree"
  input {
    int[] nums
  }
  stack {
    // Iterative approach using explicit stack to simulate recursion
    // Each stack entry: { left, right, stage, node_ref }
    // stage 0 = start, 1 = after left, 2 = after right
    
    var $length { value = $input.nums|count }
    
    conditional {
      if ($length == 0) {
        return { value = null }
      }
    }
    
    // Post-order traversal stack to build tree bottom-up
    // Each entry: { left, right, node_holder }
    var $work_stack { value = [] }
    
    // Initial call
    var.update $work_stack {
      value = $work_stack|push:{ left: 0, right: ($length - 1) }
    }
    
    // Results map: "l,r" -> tree_node
    var $results { value = {} }
    
    while (($work_stack|count) > 0) {
      each {
        var $frame { value = $work_stack|last }
        var $l { value = $frame.left }
        var $r { value = $frame.right }
        var $key { value = ($l|to_text) ~ "," ~ ($r|to_text) }
        
        // Check if already computed
        conditional {
          if ($results|has:$key) {
            var.update $work_stack { value = $work_stack|pop }
            continue
          }
        }
        
        var $mid { value = ($l + $r) / 2 }
        var $val { value = $input.nums|get:($mid|to_text) }
        
        var $left_key { value = ($l|to_text) ~ "," ~ (($mid - 1)|to_text) }
        var $right_key { value = (($mid + 1)|to_text) ~ "," ~ ($r|to_text) }
        
        conditional {
          if ($l > $r) {
            // Empty range returns null
            var.update $results { value = $results|set:$key:null }
            var.update $work_stack { value = $work_stack|pop }
            continue
          }
        }
        
        // Check if children are ready
        var $left_ready { value = ($l > ($mid - 1)) || ($results|has:$left_key) }
        var $right_ready { value = (($mid + 1) > $r) || ($results|has:$right_key) }
        
        conditional {
          if ($left_ready && $right_ready) {
            // Build this node
            var $left_child { value = null }
            var $right_child { value = null }
            
            conditional {
              if ($l <= ($mid - 1)) {
                var.update $left_child { value = $results|get:$left_key }
              }
            }
            
            conditional {
              if (($mid + 1) <= $r) {
                var.update $right_child { value = $results|get:$right_key }
              }
            }
            
            var $tree_node {
              value = {
                val: $val,
                left: $left_child,
                right: $right_child
              }
            }
            
            var.update $results { value = $results|set:$key:$tree_node }
            var.update $work_stack { value = $work_stack|pop }
          }
          else {
            // Push children that aren't ready yet
            // Push right first so left is processed first
            conditional {
              if (!$right_ready) {
                var.update $work_stack {
                  value = $work_stack|push:{ left: ($mid + 1), right: $r }
                }
              }
            }
            
            conditional {
              if (!$left_ready) {
                var.update $work_stack {
                  value = $work_stack|push:{ left: $l, right: ($mid - 1) }
                }
              }
            }
          }
        }
      }
    }
    
    var $result { value = $results|get:"0," ~ (($length - 1)|to_text) }
  }
  response = $result
}
