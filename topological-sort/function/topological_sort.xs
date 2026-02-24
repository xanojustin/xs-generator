// Topological Sort - Return a valid ordering of nodes in a directed acyclic graph (DAG)
// Uses Kahn's algorithm to produce a topological ordering
// If a cycle exists, returns an empty array
function "topological_sort" {
  description = "Returns a topological ordering of nodes given directed edges"

  input {
    int num_nodes { description = "Total number of nodes (labeled 0 to num_nodes-1)" }
    object[] edges {
      description = "Array of [from, to] directed edges"
    }
  }

  stack {
    // Build adjacency list and in-degree count
    var $graph { value = {} }
    var $in_degree { value = [] }
    var $i { value = 0 }

    // Initialize in-degree array with zeros
    while ($i < $input.num_nodes) {
      each {
        var $in_degree { value = $in_degree|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }

    // Build graph and count in-degrees
    var $edge_list { value = $input.edges }
    var $j { value = 0 }

    while ($j < ($edge_list|count)) {
      each {
        var $pair { value = $edge_list[$j] }
        var $from_node { value = $pair[0] }
        var $to_node { value = $pair[1] }

        // Add edge: from_node -> to_node
        var $from_key { value = $from_node|to_text }
        var $current_neighbors { value = $graph[$from_key] }
        
        // If key doesn't exist, initialize with empty array
        conditional {
          if ($current_neighbors == null) {
            var $current_neighbors { value = [] }
          }
        }
        
        var $new_neighbors { value = $current_neighbors|merge:[$to_node] }
        var $graph { value = $graph|set:$from_key:$new_neighbors }

        // Increment in-degree of to_node
        var $current_degree { value = $in_degree[$to_node] }
        var $new_degree { value = $current_degree + 1 }
        var $in_degree { value = $in_degree|set:$to_node:$new_degree }

        var.update $j { value = $j + 1 }
      }
    }

    // Initialize queue with all nodes having 0 in-degree
    var $queue { value = [] }
    var $k { value = 0 }
    while ($k < $input.num_nodes) {
      each {
        conditional {
          if ($in_degree[$k] == 0) {
            var $queue { value = $queue|merge:[$k] }
          }
        }
        var.update $k { value = $k + 1 }
      }
    }

    // Process queue (Kahn's algorithm) and build result
    var $result { value = [] }
    var $queue_idx { value = 0 }

    while ($queue_idx < ($queue|count)) {
      each {
        var $current { value = $queue[$queue_idx] }
        var $result { value = $result|merge:[$current] }

        // Get neighbors
        var $current_key { value = $current|to_text }
        var $neighbors { value = $graph[$current_key] }
        
        // Skip if no neighbors
        conditional {
          if ($neighbors != null) {
            var $n { value = 0 }
            while ($n < ($neighbors|count)) {
              each {
                var $neighbor { value = $neighbors[$n] }
                var $neighbor_degree { value = $in_degree[$neighbor] }
                var $new_neighbor_degree { value = $neighbor_degree - 1 }
                var $in_degree { value = $in_degree|set:$neighbor:$new_neighbor_degree }

                conditional {
                  if ($new_neighbor_degree == 0) {
                    var $queue { value = $queue|merge:[$neighbor] }
                  }
                }

                var.update $n { value = $n + 1 }
              }
            }
          }
        }

        var.update $queue_idx { value = $queue_idx + 1 }
      }
    }

    // If we didn't process all nodes, there's a cycle - return empty array
    conditional {
      if (($result|count) != $input.num_nodes) {
        var $result { value = [] }
      }
    }
  }

  response = $result
}
