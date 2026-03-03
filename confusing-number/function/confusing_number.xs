function "confusing_number" {
  description = "Check if a number is confusing (rotates 180° to a different valid number)"
  input {
    int n filters=min:0
  }
  stack {
    // Digits that are valid when rotated: 0, 1, 6, 8, 9
    // Mapping: 0->0, 1->1, 6->9, 8->8, 9->6
    
    var $num_str {
      value = $input.n|to_text
    }
    
    var $rotated_chars {
      value = []
    }
    
    var $is_valid {
      value = true
    }
    
    var $i {
      value = ($num_str|strlen) - 1
    }
    
    // Process digits from right to left (to build rotated number)
    while ($i >= 0) {
      each {
        var $char {
          value = $num_str|substr:$i:1
        }
        
        conditional {
          if ($char == "0") {
            var.update $rotated_chars {
              value = $rotated_chars|push:"0"
            }
          }
          elseif ($char == "1") {
            var.update $rotated_chars {
              value = $rotated_chars|push:"1"
            }
          }
          elseif ($char == "6") {
            var.update $rotated_chars {
              value = $rotated_chars|push:"9"
            }
          }
          elseif ($char == "8") {
            var.update $rotated_chars {
              value = $rotated_chars|push:"8"
            }
          }
          elseif ($char == "9") {
            var.update $rotated_chars {
              value = $rotated_chars|push:"6"
            }
          }
          else {
            // Invalid digit (2, 3, 4, 5, 7)
            var.update $is_valid {
              value = false
            }
          }
        }
        
        var.update $i {
          value = $i - 1
        }
      }
    }
    
    var $result {
      value = false
    }
    
    // If all digits were valid, check if rotated number is different
    conditional {
      if ($is_valid) {
        var $rotated_str {
          value = $rotated_chars|join:""
        }
        
        // If rotated equals original, it's NOT confusing (it's the same)
        var.update $result {
          value = $rotated_str != $num_str
        }
      }
    }
  }
  response = $result
}
