function "find_destination_city" {
  description = "Find the destination city from a list of travel paths"
  input {
    json paths { description = "Array of paths where each path is [source_city, destination_city]" }
  }
  stack {
    // Build a set of all source cities (cities that have outgoing paths)
    var $sources { value = [] }
    
    foreach ($input.paths) {
      each as $path {
        // First element is the source city
        var $source { value = $path|first }
        var.update $sources { value = $sources|append:$source }
      }
    }
    
    // Find the destination city - it's the one that appears as destination but not as source
    var $destination { value = null }
    
    foreach ($input.paths) {
      each as $path {
        // Second element is the destination city
        var $dest { value = $path|slice:1:1|first }
        
        // Check if this destination is NOT in sources
        conditional {
          if (!($sources|contains:$dest)) {
            var.update $destination { value = $dest }
          }
        }
      }
    }
  }
  response = $destination
}
