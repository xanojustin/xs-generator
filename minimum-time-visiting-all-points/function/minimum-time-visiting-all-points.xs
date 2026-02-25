// Minimum Time Visiting All Points
// On a 2D plane, there are n points with integer coordinates points[i] = [xi, yi].
// Return the minimum time in seconds to visit all the points in the order given by points.
// You can move according to these rules:
// - In 1 second, you can either:
//   - Move vertically by one unit
//   - Move horizontally by one unit
//   - Move diagonally (1 unit vertically and 1 unit horizontally)
// - You must visit the points in the same order as they appear in the array.
// - You are allowed to pass through points that appear later in the order.
function "minimum-time-visiting-all-points" {
  description = "Calculate minimum time to visit all points on 2D plane"
  
  input {
    object[] points { 
      description = "Array of points where each point is [x, y]" 
    }
  }
  
  stack {
    var $total_time { value = 0 }
    var $i { value = 0 }
    
    // Handle edge case: 0 or 1 point
    conditional {
      if (($input.points|count) <= 1) {
        return { value = 0 }
      }
    }
    
    // Calculate time between consecutive points
    while ($i < ($input.points|count) - 1) {
      each {
        // Get current and next point
        var $current { value = $input.points[$i] }
        var $next { value = $input.points[$i + 1] }
        
        // Calculate differences in x and y
        var $dx { value = $next[0] - $current[0] }
        var $dy { value = $next[1] - $current[1] }
        
        // Calculate absolute value of dx
        var $abs_dx { value = $dx }
        conditional {
          if ($dx < 0) {
            var $abs_dx { value = 0 - $dx }
          }
        }
        
        // Calculate absolute value of dy
        var $abs_dy { value = $dy }
        conditional {
          if ($dy < 0) {
            var $abs_dy { value = 0 - $dy }
          }
        }
        
        // Time is max of abs(dx) and abs(dy) because we can move diagonally
        // Diagonal moves cover both x and y simultaneously
        var $step_time { value = $abs_dy }
        conditional {
          if ($abs_dx > $abs_dy) {
            var $step_time { value = $abs_dx }
          }
        }
        
        var $total_time { value = $total_time + $step_time }
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $total_time
}
