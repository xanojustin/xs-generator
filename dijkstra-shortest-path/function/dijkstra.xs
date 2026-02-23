// Dijkstra Shortest Path Algorithm
// Finds the shortest path from a start node to all other nodes in a weighted graph
function "dijkstra" {
  description = "Find shortest paths from start node to all other nodes using Dijkstra algorithm"
  input {
    json graph
    text start_node
  }
  stack {
    var $distances { value = {} }
    var $visited { value = {} }
    var $previous { value = {} }
    var $nodes { value = $input.graph|keys }
    foreach ($nodes) {
      each as $node {
        var $distances {
          value = $distances|set:$node:null
        }
        var $visited {
          value = $visited|set:$node:false
        }
        var $previous {
          value = $previous|set:$node:null
        }
      }
    }
    var $distances {
      value = $distances|set:$input.start_node:0
    }
    var $unvisited_count { value = $nodes|count }
    while ($unvisited_count > 0) {
      each {
        var $current_node { value = null }
        var $current_dist { value = null }
        foreach ($nodes) {
          each as $node {
            var $is_visited { value = $visited|get:$node }
            conditional {
              if (!$is_visited) {
                var $node_dist { value = $distances|get:$node }
                conditional {
                  if ($node_dist != null) {
                    conditional {
                      if ($current_dist == null || $node_dist < $current_dist) {
                        var $current_dist { value = $node_dist }
                        var $current_node { value = $node }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        conditional {
          if ($current_node == null) {
            var $unvisited_count { value = 0 }
          }
          else {
            var $visited {
              value = $visited|set:$current_node:true
            }
            var $unvisited_count { value = $unvisited_count - 1 }
            var $neighbors { value = $input.graph|get:$current_node }
            conditional {
              if ($neighbors != null) {
                foreach ($neighbors) {
                  each as $edge {
                    var $neighbor { value = $edge|get:"to" }
                    var $weight { value = $edge|get:"weight" }
                    var $neighbor_visited { value = $visited|get:$neighbor }
                    conditional {
                      if (!$neighbor_visited) {
                        var $alt { value = $current_dist + $weight }
                        var $neighbor_dist { value = $distances|get:$neighbor }
                        conditional {
                          if ($neighbor_dist == null || $alt < $neighbor_dist) {
                            var $distances {
                              value = $distances|set:$neighbor:$alt
                            }
                            var $previous {
                              value = $previous|set:$neighbor:$current_node
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    var $result { value = {} }
    foreach ($nodes) {
      each as $node {
        var $path { value = [] }
        var $path_node { value = $node }
        while ($path_node != null) {
          each {
            var $path { value = [$path_node]|merge:$path }
            var $path_node { value = $previous|get:$path_node }
          }
        }
        var $node_result {
          value = {
            distance: $distances|get:$node,
            path: $path
          }
        }
        var $result {
          value = $result|set:$node:$node_result
        }
      }
    }
  }
  response = $result
}