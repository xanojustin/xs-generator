// Graph Bipartite Check - LeetCode 785
// Determines if an undirected graph is bipartite using BFS coloring
// A graph is bipartite if nodes can be divided into two sets where
// every edge connects nodes from different sets
function "is_bipartite" {
  description = "Checks if an undirected graph is bipartite using BFS two-coloring"
  
  input {
    json graph { description = "Adjacency list representation of the graph where graph[i] contains neighbors of node i" }
  }
  
  stack {
    // Colors array: -1 = uncolored, 0 = color A, 1 = color B
    var $node_count { value = $input.graph|count }
    var $colors { value = (0..($node_count - 1))|fill:-1 }
    var $is_bipartite { value = true }
    var $start_node { value = 0 }
    
    // Try to color each connected component
    while ($start_node < ($input.graph|count) && $is_bipartite) {
      each {
        // If current node is uncolored, start BFS from it
        conditional {
          if ($colors[$start_node] == -1) {
            // BFS queue - start with current node
            var $queue { value = [$start_node] }
            var.update $colors[$start_node] { value = 0 }
            
            // BFS traversal
            while ((($queue|count) > 0) && $is_bipartite) {
              each {
                // Dequeue
                var $current { value = $queue|first }
                var.update $queue { value = $queue|slice:1:($queue|count) }
                var $current_color { value = $colors[$current] }
                var $neighbors { value = $input.graph[$current] }
                var $n_idx { value = 0 }
                
                // Check all neighbors
                while ($n_idx < ($neighbors|count) && $is_bipartite) {
                  each {
                    var $neighbor { value = $neighbors[$n_idx] }
                    var $neighbor_color { value = $colors[$neighbor] }
                    
                    conditional {
                      // If neighbor is uncolored, color with opposite color
                      if ($neighbor_color == -1) {
                        var $new_color { value = 1 - $current_color }
                        var.update $colors[$neighbor] { value = $new_color }
                        var.update $queue { value = $queue|push:$neighbor }
                      }
                      // If neighbor has same color, graph is not bipartite
                      elseif ($neighbor_color == $current_color) {
                        var.update $is_bipartite { value = false }
                      }
                    }
                    
                    var.update $n_idx { value = $n_idx + 1 }
                  }
                }
              }
            }
          }
        }
        
        var.update $start_node { value = $start_node + 1 }
      }
    }
  }
  
  response = $is_bipartite
}
