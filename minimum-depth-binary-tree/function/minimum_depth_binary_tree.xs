// Minimum Depth of Binary Tree
// Given a binary tree, find its minimum depth - the number of nodes along the shortest path
// from the root node down to the nearest leaf node.
// A leaf is a node with no children.
// Uses BFS (level-order traversal) for optimal performance - stops at first leaf found.
function "minimum_depth_binary_tree" {
  description = "Finds the minimum depth of a binary tree using BFS"
  
  input {
    json root { description = "Binary tree node with 'val', 'left', and 'right' properties" }
  }
  
  stack {
    // Handle empty tree - return early
    conditional {
      if ($input.root == null) {
        return { value = 0 }
      }
    }
    
    // BFS using a queue - each entry contains node and its depth
    var $queue { value = [{ node: $input.root, depth: 1 }] }
    var $min_depth { value = 0 }
    var $found { value = false }
    var $front { value = 0 }
    
    // BFS loop - process nodes level by level
    while (($front < ($queue|count)) && !$found) {
      each {
        var $current { value = $queue[$front] }
        var $node { value = $current.node }
        var $depth { value = $current.depth }
        
        // Check if current node is a leaf (no children)
        conditional {
          if (($node.left == null) && ($node.right == null)) {
            var $min_depth { value = $depth }
            var $found { value = true }
          }
          else {
            // Add left child to queue if exists
            conditional {
              if ($node.left != null) {
                var $queue { 
                  value = $queue|merge:[{ node: $node.left, depth: $depth + 1 }] 
                }
              }
            }
            
            // Add right child to queue if exists
            conditional {
              if ($node.right != null) {
                var $queue { 
                  value = $queue|merge:[{ node: $node.right, depth: $depth + 1 }] 
                }
              }
            }
          }
        }
        
        var.update $front { value = $front + 1 }
      }
    }
  }
  
  response = $min_depth
}
