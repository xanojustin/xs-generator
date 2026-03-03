// Union-Find (Disjoint Set Union) Data Structure
// Implements path compression and union by rank for optimal performance
// Supports: find (with path compression), union (with union by rank), connected check
function "union_find" {
  description = "Union-Find data structure with path compression and union by rank"
  
  input {
    int n { description = "Number of elements (0 to n-1)" }
    object[] operations { 
      description = "Array of operations to perform: {type: 'union'|'find'|'connected', params: [...]}"
    }
  }
  
  stack {
    // Initialize parent object: parent[i] = i (each element is its own parent)
    // Using object instead of array because XanoScript doesn't support array element updates
    var $parent { value = {} }
    var $i { value = 0 }
    while ($i < $input.n) {
      each {
        var $key_i { value = $i|to_text }
        var.update $parent { value = $parent|set:$key_i:$i }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Initialize rank object: rank[i] = 0 (all trees start with height 0)
    var $rank { value = {} }
    var $j { value = 0 }
    while ($j < $input.n) {
      each {
        var $key_j { value = $j|to_text }
        var.update $rank { value = $rank|set:$key_j:0 }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Helper function: find with path compression
    // Returns the root of the set containing x
    // Not a real function - we'll inline the logic
    
    // Results array to store operation results
    var $results { value = [] }
    
    // Process each operation
    foreach ($input.operations) {
      each as $op {
        var $op_type { value = $op|get:"type" }
        var $op_params { value = $op|get:"params" }
        
        conditional {
          // FIND operation - returns the root of the set containing x
          if ($op_type == "find") {
            var $x { value = $op_params|first }
            var $x_key { value = $x|to_text }
            
            // Find root with path compression (inline implementation)
            var $root { value = $x }
            var $root_key { value = $root|to_text }
            var $parent_of_root { value = $parent|get:$root_key }
            
            // Find the root
            while ($root != $parent_of_root) {
              each {
                var.update $root { value = $parent_of_root }
                var.update $root_key { value = $root|to_text }
                var.update $parent_of_root { value = $parent|get:$root_key }
              }
            }
            
            // Path compression: update parent of x to point directly to root
            // Need to traverse from x to root again to compress path
            var $curr { value = $x }
            var $curr_key { value = $curr|to_text }
            var $parent_of_curr { value = $parent|get:$curr_key }
            
            while ($curr != $root) {
              each {
                var $next { value = $parent_of_curr }
                var $next_key { value = $next|to_text }
                // Update parent of curr to root
                var.update $parent { value = $parent|set:$curr_key:$root }
                var.update $curr { value = $next }
                var.update $curr_key { value = $curr|to_text }
                var.update $parent_of_curr { value = $parent|get:$curr_key }
              }
            }
            
            array.push $results { value = { operation: "find", x: $x, result: $root } }
          }
          
          // UNION operation - merges the sets containing x and y
          elseif ($op_type == "union") {
            var $x_union { value = $op_params|get:0 }
            var $y_union { value = $op_params|get:1 }
            var $xu_key { value = $x_union|to_text }
            var $yu_key { value = $y_union|to_text }
            
            // Find root of x
            var $root_x { value = $x_union }
            var $rx_key { value = $root_x|to_text }
            var $parent_x { value = $parent|get:$rx_key }
            while ($root_x != $parent_x) {
              each {
                var.update $root_x { value = $parent_x }
                var.update $rx_key { value = $root_x|to_text }
                var.update $parent_x { value = $parent|get:$rx_key }
              }
            }
            
            // Find root of y
            var $root_y { value = $y_union }
            var $ry_key { value = $root_y|to_text }
            var $parent_y { value = $parent|get:$ry_key }
            while ($root_y != $parent_y) {
              each {
                var.update $root_y { value = $parent_y }
                var.update $ry_key { value = $root_y|to_text }
                var.update $parent_y { value = $parent|get:$ry_key }
              }
            }
            
            // If already in the same set, nothing to do
            conditional {
              if ($root_x != $root_y) {
                // Union by rank: attach smaller rank tree under larger rank tree
                var $rx_key2 { value = $root_x|to_text }
                var $ry_key2 { value = $root_y|to_text }
                var $rank_x { value = $rank|get:$rx_key2 }
                var $rank_y { value = $rank|get:$ry_key2 }
                
                conditional {
                  if ($rank_x < $rank_y) {
                    // Make y's root the parent
                    var.update $parent { value = $parent|set:$rx_key2:$root_y }
                  }
                  elseif ($rank_x > $rank_y) {
                    // Make x's root the parent
                    var.update $parent { value = $parent|set:$ry_key2:$root_x }
                  }
                  else {
                    // Equal rank: make x's root the parent and increment rank
                    var.update $parent { value = $parent|set:$ry_key2:$root_x }
                    var $new_rank { value = $rank_x + 1 }
                    var.update $rank { value = $rank|set:$rx_key2:$new_rank }
                  }
                }
              }
            }
            
            array.push $results { value = { operation: "union", x: $x_union, y: $y_union, success: true } }
          }
          
          // CONNECTED operation - checks if x and y are in the same set
          elseif ($op_type == "connected") {
            var $x_conn { value = $op_params|get:0 }
            var $y_conn { value = $op_params|get:1 }
            var $xc_key { value = $x_conn|to_text }
            var $yc_key { value = $y_conn|to_text }
            
            // Find root of x
            var $root_xc { value = $x_conn }
            var $rxc_key { value = $root_xc|to_text }
            var $parent_xc { value = $parent|get:$rxc_key }
            while ($root_xc != $parent_xc) {
              each {
                var.update $root_xc { value = $parent_xc }
                var.update $rxc_key { value = $root_xc|to_text }
                var.update $parent_xc { value = $parent|get:$rxc_key }
              }
            }
            
            // Find root of y
            var $root_yc { value = $y_conn }
            var $ryc_key { value = $root_yc|to_text }
            var $parent_yc { value = $parent|get:$ryc_key }
            while ($root_yc != $parent_yc) {
              each {
                var.update $root_yc { value = $parent_yc }
                var.update $ryc_key { value = $root_yc|to_text }
                var.update $parent_yc { value = $parent|get:$ryc_key }
              }
            }
            
            var $is_connected { value = $root_xc == $root_yc }
            
            array.push $results { 
              value = { 
                operation: "connected", 
                x: $x_conn, 
                y: $y_conn, 
                result: $is_connected 
              } 
            }
          }
        }
      }
    }
    
    // Get final parent and rank state for verification
    var $final_state { 
      value = { 
        parent: $parent,
        rank: $rank
      } 
    }
  }
  
  response = {
    operations: $results,
    final_state: $final_state
  }
}