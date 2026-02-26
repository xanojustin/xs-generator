function "counting_valleys" {
  description = "Count the number of valleys traversed during a hike"
  input {
    text steps filters=trim { description = "String of 'U' (up) and 'D' (down) steps" }
  }
  stack {
    var $elevation { value = 0 }
    var $valley_count { value = 0 }
    var $in_valley { value = false }
    var $step_index { value = 0 }
    var $step_count { value = $input.steps|strlen }
    
    while ($step_index < $step_count) {
      each {
        var $step { value = $input.steps|substr:$step_index:1 }
        
        conditional {
          if ($step == "U") {
            var.update $elevation { value = $elevation + 1 }
          }
          else {
            var.update $elevation { value = $elevation - 1 }
          }
        }
        
        conditional {
          if ($elevation < 0) {
            var.update $in_valley { value = true }
          }
          elseif ($elevation == 0 && $in_valley) {
            var.update $valley_count { value = $valley_count + 1 }
            var.update $in_valley { value = false }
          }
        }
        
        var.update $step_index { value = $step_index + 1 }
      }
    }
  }
  response = $valley_count
}
