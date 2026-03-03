function "scramble_string" {
  description = "Determines if s2 is a scrambled version of s1"
  
  input {
    text s1 { description = "Original string" }
    text s2 { description = "String to check if it's a scrambled version of s1" }
  }
  
  stack {
    conditional {
      if (($input.s1|strlen) != ($input.s2|strlen)) {
        return { value = false }
      }
    }
    
    conditional {
      if ($input.s1 == $input.s2) {
        return { value = true }
      }
    }
    
    var $sorted_s1 {
      value = $input.s1|split:""|sort|join:""
    }
    var $sorted_s2 {
      value = $input.s2|split:""|sort|join:""
    }
    
    conditional {
      if ($sorted_s1 != $sorted_s2) {
        return { value = false }
      }
    }
    
    var $n { value = $input.s1|strlen }
    
    var $i { value = 1 }
    var $result { value = false }
    
    while (($i < $n) && ($result == false)) {
      each {
        var $s1_left { value = $input.s1|substr:0:$i }
        var $s1_right { value = $input.s1|substr:$i }
        
        var $s2_left { value = $input.s2|substr:0:$i }
        var $s2_right { value = $input.s2|substr:$i }
        
        function.run "scramble_string" {
          input = { s1: $s1_left, s2: $s2_left }
        } as $left_check
        
        conditional {
          if ($left_check == true) {
            function.run "scramble_string" {
              input = { s1: $s1_right, s2: $s2_right }
            } as $right_check
            
            conditional {
              if ($right_check == true) {
                var.update $result { value = true }
              }
            }
          }
        }
        
        conditional {
          if ($result == false) {
            var $s2_swap_left { value = $input.s2|substr:0:($n - $i) }
            var $s2_swap_right { value = $input.s2|substr:($n - $i) }
            
            function.run "scramble_string" {
              input = { s1: $s1_left, s2: $s2_swap_right }
            } as $left_swap_check
            
            conditional {
              if ($left_swap_check == true) {
                function.run "scramble_string" {
                  input = { s1: $s1_right, s2: $s2_swap_left }
                } as $right_swap_check
                
                conditional {
                  if ($right_swap_check == true) {
                    var.update $result { value = true }
                  }
                }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
