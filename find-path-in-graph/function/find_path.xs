function "find_path" {
  description = "Determine if a valid path exists from source to destination in an undirected graph"
  input {
    int n filters=min:1 { description = "Number of vertices (0 to n-1)" }
    object[] edges { 
      description = "Array of edges, each with source and target vertices"
    }
    int source { description = "Starting vertex" }
    int destination { description = "Target vertex" }
  }
  stack {
    // Edge case: source equals destination
    conditional {
      if ($input.source == $input.destination) {
        return { value = true }
      }
    }

    // Build adjacency list
    var $adj { value = {} }
    foreach ($input.edges) {
      each as $edge {
        var $u { value = $edge.source|to_text }
        var $v { value = $edge.target|to_text }
        
        // Add v to u's adjacency list
        conditional {
          if ($adj|has:$u) {
            var $u_list { value = $adj|get:$u }
            var $u_list { value = $u_list|push:$edge.target }
            var $adj { value = $adj|set:$u:$u_list }
          }
          else {
            var $adj { value = $adj|set:$u:[$edge.target] }
          }
        }
        
        // Add u to v's adjacency list (bi-directional)
        conditional {
          if ($adj|has:$v) {
            var $v_list { value = $adj|get:$v }
            var $v_list { value = $v_list|push:$edge.source }
            var $adj { value = $adj|set:$v:$v_list }
          }
          else {
            var $adj { value = $adj|set:$v:[$edge.source] }
          }
        }
      }
    }

    // BFS traversal
    var $visited { value = {} }
    var $queue { value = [$input.source] }
    var $found { value = false }
    
    // Mark source as visited
    var $source_text { value = $input.source|to_text }
    var $visited { value = $visited|set:$source_text:true }

    while (($queue|count) > 0 && !$found) {
      each {
        // Dequeue - get first element and slice the rest
        var $current { value = $queue|first }
        var $queue_len { value = $queue|count }
        var $queue { value = $queue|slice:1:$queue_len }
        var $current_text { value = $current|to_text }

        // Check if we reached destination
        conditional {
          if ($current == $input.destination) {
            var $found { value = true }
          }
        }

        // Skip if already found
        conditional {
          if (!$found) {
            // Get neighbors
            var $neighbors { value = [] }
            conditional {
              if ($adj|has:$current_text) {
                var $neighbors { value = $adj|get:$current_text }
              }
            }

            // Process neighbors
            foreach ($neighbors) {
              each as $neighbor {
                var $neighbor_text { value = $neighbor|to_text }
                var $is_visited { value = $visited|has:$neighbor_text }
                conditional {
                  if (!$is_visited) {
                    var $visited { value = $visited|set:$neighbor_text:true }
                    var $queue { value = $queue|push:$neighbor }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = $found
}
