function "find_center" {
  description = "Finds the center node of a star graph given its edges"
  input {
    json edges { description = "Array of edges where each edge is a pair of connected nodes" }
  }
  stack {
    // In a star graph, the center node appears in every edge
    // The center must be one of the two nodes from the first edge
    // We check which node from the first edge also appears in the second edge
    
    var $first_edge { value = $input.edges|first }
    var $second_edge { value = $input.edges|get:1 }
    
    var $node_a { value = $first_edge|get:0 }
    var $node_b { value = $first_edge|get:1 }
    
    // Check if node_a is in the second edge
    var $center { value = $node_b }
    
    conditional {
      if (($second_edge|get:0) == $node_a || ($second_edge|get:1) == $node_a) {
        var.update $center { value = $node_a }
      }
    }
  }
  response = $center
}
