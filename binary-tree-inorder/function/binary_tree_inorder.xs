// Binary Tree In-Order Traversal
// Performs in-order traversal: left subtree -> root -> right subtree
// Returns an array of values in traversal order
function "binary_tree_inorder" {
  description = "Performs in-order traversal of a binary tree and returns values"
  
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
    
    var $result { value = [] }
    var $stack { value = [] }
    var $current { value = $input.root_index }
    
    while (($current != null) || (($stack|count) > 0)) {
      each {
        // Go as far left as possible, pushing nodes onto stack
        while ($current != null) {
          each {
            var $stack {
              value = $stack|merge:[$current]
            }
            // Get left child index
            var $current { 
              value = $input.nodes[$current]|get:"left":null 
            }
          }
        }
        
        // Pop from stack and process
        conditional {
          if (($stack|count) > 0) {
            // Pop node index
            var $node_idx { value = $stack|last }
            var $stack {
              value = $stack|slice:0:-1
            }
            
            // Get the node and add its value to result
            var $node { value = $input.nodes[$node_idx] }
            var $node_value { value = $node|get:"value":0 }
            var $result {
              value = $result|merge:[$node_value]
            }
            
            // Move to right subtree
            var $current { 
              value = $node|get:"right":null 
            }
          }
        }
      }
    }
  }
  
  response = $result
}
