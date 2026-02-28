// Sort the People - Sort people by height in descending order
// Given arrays of names and heights, return names sorted by height (tallest first)
function "sort_the_people" {
  description = "Sorts people by height in descending order"
  
  input {
    text[] names { description = "Array of person names" }
    int[] heights { description = "Array of heights corresponding to names" }
  }
  
  stack {
    // Combine names and heights into a single array of objects for sorting
    var $people { value = [] }
    var $index { value = 0 }
    
    foreach ($input.names) {
      each as $name {
        // Get corresponding height
        var $height { value = $input.heights[$index] }
        
        // Create person object with name and height
        var $person {
          value = {
            name: $name,
            height: $height
          }
        }
        
        // Add to people array
        var $people {
          value = $people|merge:[$person]
        }
        
        var.update $index { value = $index + 1 }
      }
    }
    
    // Sort people by height in descending order using bubble sort
    var $n { value = $people|count }
    
    while ($n > 1) {
      each {
        var $i { value = 0 }
        var $swapped { value = false }
        
        while ($i < $n - 1) {
          each {
            // Get adjacent people's heights
            var $current_height { value = $people[$i].height }
            var $next_height { value = $people[$i + 1].height }
            
            // Swap if current height < next height (for descending order)
            conditional {
              if ($current_height < $next_height) {
                // Perform swap of entire person objects
                var $temp { value = $people[$i] }
                var.update $people[$i] { value = $people[$i + 1] }
                var.update $people[$i + 1] { value = $temp }
                var $swapped { value = true }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        // Reduce range since largest element is now at the end
        var.update $n { value = $n - 1 }
        
        // If no swaps occurred, array is sorted
        conditional {
          if ($swapped == false) {
            // Force exit by setting n to 1
            var.update $n { value = 1 }
          }
        }
      }
    }
    
    // Extract just the names from sorted people
    var $sorted_names { value = [] }
    var $j { value = 0 }
    
    while ($j < ($people|count)) {
      each {
        var $sorted_names {
          value = $sorted_names|merge:[$people[$j].name]
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  
  response = $sorted_names
}
