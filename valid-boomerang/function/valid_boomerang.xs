// Valid Boomerang - Check if three points form a valid boomerang
// A valid boomerang means the three points are distinct and not collinear
function "valid_boomerang" {
  description = "Check if three points form a valid boomerang (not collinear)"
  
  input {
    object point1 {
      schema {
        int x
        int y
      }
    }
    object point2 {
      schema {
        int x
        int y
      }
    }
    object point3 {
      schema {
        int x
        int y
      }
    }
  }
  
  stack {
    // Three points form a boomerang if they are NOT collinear (not in a straight line)
    // Points are collinear if the area of the triangle they form is zero
    // Area = 0.5 * |x1(y2-y3) + x2(y3-y1) + x3(y1-y2)|
    // Points are collinear when: x1(y2-y3) + x2(y3-y1) + x3(y1-y2) == 0
    
    var $p1x { value = $input.point1.x }
    var $p1y { value = $input.point1.y }
    var $p2x { value = $input.point2.x }
    var $p2y { value = $input.point2.y }
    var $p3x { value = $input.point3.x }
    var $p3y { value = $input.point3.y }
    
    // Calculate twice the signed area (avoiding floating point)
    var $term1 { value = $p1x * ($p2y - $p3y) }
    var $term2 { value = $p2x * ($p3y - $p1y) }
    var $term3 { value = $p3x * ($p1y - $p2y) }
    var $area2 { value = $term1 + $term2 + $term3 }
    
    // Check if all points are distinct
    var $p1_eq_p2 {
      value = ($p1x == $p2x) && ($p1y == $p2y)
    }
    
    var $p1_eq_p3 {
      value = ($p1x == $p3x) && ($p1y == $p3y)
    }
    
    var $p2_eq_p3 {
      value = ($p2x == $p3x) && ($p2y == $p3y)
    }
    
    // Valid boomerang: area is not zero AND all points are distinct
    var $is_valid {
      value = ($area2 != 0) && !$p1_eq_p2 && !$p1_eq_p3 && !$p2_eq_p3
    }
  }
  
  response = $is_valid
}
