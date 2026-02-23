// Course Schedule - Determine if all courses can be completed
// Uses Kahn's algorithm (topological sort) to detect cycles in prerequisite graph
function "can_finish" {
  description = "Determines if all courses can be finished given prerequisites"

  input {
    int num_courses { description = "Total number of courses (labeled 0 to num_courses-1)" }
    object[] prerequisites {
      description = "Array of [course, prerequisite] pairs"
    }
  }

  stack {
    // Build adjacency list and in-degree count
    var $graph { value = {} }
    var $in_degree { value = [] }
    var $i { value = 0 }

    // Initialize in-degree array with zeros
    while ($i < $input.num_courses) {
      each {
        var $in_degree { value = $in_degree|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }

    // Build graph and count in-degrees
    var $prereq_list { value = $input.prerequisites }
    var $j { value = 0 }

    while ($j < ($prereq_list|count)) {
      each {
        var $pair { value = $prereq_list[$j] }
        var $course { value = $pair[0] }
        var $prereq { value = $pair[1] }

        // Add edge: prereq -> course
        var $prereq_key { value = $prereq|to_text }
        var $current_neighbors { value = $graph[$prereq_key] }
        
        // If key doesn't exist, initialize with empty array
        conditional {
          if ($current_neighbors == null) {
            var $current_neighbors { value = [] }
          }
        }
        
        var $new_neighbors { value = $current_neighbors|merge:[$course] }
        var $graph { value = $graph|set:$prereq_key:$new_neighbors }

        // Increment in-degree of course
        var $current_degree { value = $in_degree[$course] }
        var $new_degree { value = $current_degree + 1 }
        var $in_degree { value = $in_degree|set:$course:$new_degree }

        var.update $j { value = $j + 1 }
      }
    }

    // Initialize queue with all courses having 0 in-degree
    var $queue { value = [] }
    var $k { value = 0 }
    while ($k < $input.num_courses) {
      each {
        conditional {
          if ($in_degree[$k] == 0) {
            var $queue { value = $queue|merge:[$k] }
          }
        }
        var.update $k { value = $k + 1 }
      }
    }

    // Process queue (Kahn's algorithm)
    var $processed { value = 0 }
    var $queue_idx { value = 0 }

    while ($queue_idx < ($queue|count)) {
      each {
        var $current { value = $queue[$queue_idx] }
        var.update $processed { value = $processed + 1 }

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

    // If we processed all courses, no cycle exists
    var $can_finish { value = ($processed == $input.num_courses) }
  }

  response = $can_finish
}
