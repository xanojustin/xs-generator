function "valid-boomerang" {
  description = "Check if three points form a valid boomerang (not collinear)"
  input {
    object[] points {
      description = "Array of 3 points, each with x and y coordinates"
      schema {
        int x
        int y
      }
    }
  }
  stack {
    // Extract the three points
    var $p1 { value = $points|first }
    var $p2 { value = $points|slice:1:2|first }
    var $p3 { value = $points|slice:2:3|first }
    
    // Calculate vectors from point 1 to point 2, and point 1 to point 3
    var $x1 { value = $p1.x }
    var $y1 { value = $p1.y }
    var $x2 { value = $p2.x }
    var $y2 { value = $p2.y }
    var $x3 { value = $p3.x }
    var $y3 { value = $p3.y }
    
    // Calculate the cross product to check for collinearity
    // Points are collinear if (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
    // This avoids division and handles vertical lines correctly
    var $dx1 { value = $x2 - $x1 }
    var $dy1 { value = $y2 - $y1 }
    var $dx2 { value = $x3 - $x2 }
    var $dy2 { value = $y3 - $y2 }
    
    // Cross product
    var $cross { value = ($dy1 * $dx2) - ($dy2 * $dx1) }
    
    // Valid boomerang if cross product is not zero (points are not collinear)
    var $is_valid { value = $cross != 0 }
  }
  response = $is_valid
}
