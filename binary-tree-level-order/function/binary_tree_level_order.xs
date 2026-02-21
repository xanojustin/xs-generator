// Binary Tree Level Order Traversal
// Performs breadth-first traversal, returning nodes level by level
// Each level is returned as a separate array
// Tree structure:
//       1
//      / \
//     2   3
//    / \   \
//   4   5   6
// Level order: [[1], [2, 3], [4, 5, 6]]
function "binary_tree_level_order" {
  description = "Performs level order traversal of a binary tree and returns values grouped by level"
  
  input {
    // Array of nodes: each node has value, left (index), right (index)
    json nodes { description = "Array of tree nodes with value, left index, right index" }
    int root_index { description = "Index of the root node in the array" }
  }
  
  stack {
    // Handle empty tree
    conditional {
      if (($input.nodes|count) == 0) {
        return { value = [] }
      }
    }
    
    // Initialize result array (array of levels)
    var $result { value = [] }
    
    // Initialize queue with root index
    var $queue { value = [$input.root_index] }
    
    // Process levels until queue is empty
    while (($queue|count) > 0) {
      each {
        // Get number of nodes at current level
        var $level_size { value = $queue|count }
        var $current_level { value = [] }
        
        // Process all nodes at current level
        for ($level_size) {
          each as $i {
            // Dequeue front node
            var $node_idx { value = $queue|first }
            var $queue {
              value = $queue|slice:1
            }
            
            // Get node value and add to current level
            var $node { value = $input.nodes[$node_idx] }
            var $node_value { value = $node|get:"value":0 }
            var $current_level {
              value = $current_level|merge:[$node_value]
            }
            
            // Enqueue left child if exists
            var $left_idx { value = $node|get:"left":null }
            conditional {
              if ($left_idx != null) {
                var $queue {
                  value = $queue|merge:[$left_idx]
                }
              }
            }
            
            // Enqueue right child if exists
            var $right_idx { value = $node|get:"right":null }
            conditional {
              if ($right_idx != null) {
                var $queue {
                  value = $queue|merge:[$right_idx]
                }
              }
            }
          }
        }
        
        // Add current level to result
        var $result {
          value = $result|merge:[$current_level]
        }
      }
    }
  }
  
  response = $result
}
