function "k_closest_points" {
  description = "Find the k closest points to the origin (0,0) in a 2D plane"
  input {
    object[] points {
      description = "Array of points, each with x and y coordinates"
      schema {
        int x
        int y
      }
    }
    int k filters=min:0 {
      description = "Number of closest points to return"
    }
  }
  stack {
    // Handle edge cases - return empty array if no points or k is 0
    conditional {
      if (($input.points|count) == 0 || $input.k == 0) {
        var $result { value = [] }
      }
      else {
        // Create array of points with their squared distances
        // Using squared distance avoids expensive sqrt calculation
        var $points_with_distance { value = [] }
        
        foreach ($input.points) {
          each as $point {
            var $distance_squared {
              value = ($point.x * $point.x) + ($point.y * $point.y)
            }
            var $point_entry {
              value = {
                x: $point.x,
                y: $point.y,
                distance: $distance_squared
              }
            }
            array.push $points_with_distance {
              value = $point_entry
            }
          }
        }

        // Sort points by distance using filter
        // Syntax: |sort:field_name:type:direction
        var $sorted_points {
          value = $points_with_distance|sort:"distance":"int":false
        }

        // Take first k points and extract just x,y (without distance)
        var $k_points { value = $sorted_points|slice:0:$input.k }
        var $result { value = [] }
        
        foreach ($k_points) {
          each as $pt {
            var $clean_point {
              value = { x: $pt.x, y: $pt.y }
            }
            array.push $result {
              value = $clean_point
            }
          }
        }
      }
    }
  }
  response = $result
}
