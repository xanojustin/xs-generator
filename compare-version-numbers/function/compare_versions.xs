function "compare_versions" {
  description = "Compare two version numbers. Returns 1 if v1 > v2, -1 if v1 < v2, 0 if equal."
  input {
    text version1 filters=trim { description = "First version number (e.g., '1.0.3')" }
    text version2 filters=trim { description = "Second version number (e.g., '1.0.4')" }
  }
  stack {
    // Split version strings into arrays by dot
    var $v1_parts { value = $input.version1|split:'.' }
    var $v2_parts { value = $input.version2|split:'.' }
    
    // Get the maximum length
    var $max_len { value = ($v1_parts|count) }
    conditional {
      if (($v2_parts|count) > $max_len) {
        var.update $max_len { value = ($v2_parts|count) }
      }
    }
    
    // Compare each segment
    var $result { value = 0 }
    var $i { value = 0 }
    
    while (($i < $max_len) && ($result == 0)) {
      each {
        // Get current segment or 0 if beyond length
        var $seg1 { value = 0 }
        var $seg2 { value = 0 }
        
        conditional {
          if ($i < ($v1_parts|count)) {
            var.update $seg1 { value = $v1_parts[$i]|to_int }
          }
        }
        conditional {
          if ($i < ($v2_parts|count)) {
            var.update $seg2 { value = $v2_parts[$i]|to_int }
          }
        }
        
        // Compare segments
        conditional {
          if ($seg1 > $seg2) {
            var.update $result { value = 1 }
          }
          elseif ($seg1 < $seg2) {
            var.update $result { value = -1 }
          }
        }
        
        // Increment counter
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
