function "clone-graph" {
  description = "Clone a connected undirected graph given a starting node reference using iterative DFS"

  input {
    object node {
      description = "Starting node of the graph with val and neighbors"
      schema {
        int val { description = "Node value" }
        object[] neighbors {
          description = "Array of neighbor node references"
        }
      }
    }
  }

  stack {
    // Handle empty input
    conditional {
      if ($input.node == null) {
        return { value = null }
      }
    }

    // Map to store original node val -> cloned node
    var $node_map { value = {} }

    // Stack for iterative DFS - stores nodes to process
    var $stack { value = [$input.node] }

    // Process all nodes using iterative DFS
    while (($stack|count) > 0) {
      each {
        // Pop a node from the stack
        var $current { value = $stack|last }
        var $stack { value = $stack|slice:0:(($stack|count) - 1) }

        var $current_val { value = $current|get:"val" }
        var $current_neighbors { value = $current|get:"neighbors" }

        // Skip if already cloned
        var $existing { value = $node_map|get:($current_val|to_text) }
        conditional {
          if ($existing != null) {
            continue
          }
        }

        // Create cloned node (neighbors will be populated later)
        var $cloned {
          value = {
            val: $current_val,
            neighbors: []
          }
        }

        // Store in map
        var $node_map {
          value = $node_map|set:($current_val|to_text):$cloned
        }

        // Add neighbors to stack for processing
        var $i { value = 0 }
        var $neighbor_count { value = ($current_neighbors|count) }

        while ($i < $neighbor_count) {
          each {
            var $neighbor { value = $current_neighbors|get:$i }
            var $neighbor_val { value = $neighbor|get:"val" }

            // Check if neighbor already cloned
            var $neighbor_cloned { value = $node_map|get:($neighbor_val|to_text) }

            conditional {
              if ($neighbor_cloned != null) {
                // Neighbor already cloned, add reference to current node's neighbors
                var $cloned_neighbors { value = $cloned|get:"neighbors" }
                var $cloned_neighbors {
                  value = $cloned_neighbors|append:$neighbor_cloned
                }
                var $cloned {
                  value = $cloned|set:"neighbors":$cloned_neighbors
                }
              }
              else {
                // Neighbor not yet cloned, push to stack
                var $stack { value = $stack|append:$neighbor }
              }
            }

            var $i { value = $i + 1 }
          }
        }
      }
    }

    // Return the cloned starting node
    var $start_val { value = $input.node|get:"val" }
    var $result { value = $node_map|get:($start_val|to_text) }
  }

  response = $result
}
