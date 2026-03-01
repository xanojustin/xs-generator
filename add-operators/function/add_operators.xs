function "add_operators" {
  description = "Given a string of digits and a target value, find all ways to add operators (+, -, *) between digits to evaluate to the target."
  
  input {
    text num {
      description = "String of digits (e.g., '123')"
    }
    int target {
      description = "Target value to evaluate to"
    }
  }
  
  stack {
    // Results array to store valid expressions
    var $results {
      value = []
    }
    
    // Get the length of the input number string
    var $num_len {
      value = $input.num|strlen
    }
    
    // Handle empty input
    conditional {
      if ($num_len == 0) {
        return { value = [] }
      }
    }
    
    // Initialize work stack with first digit possibilities
    // We iterate through possible first numbers (handling multi-digit)
    var $work_stack {
      value = []
    }
    
    for ($num_len) {
      each as $i {
        var $end_pos {
          value = $i + 1
        }
        var $current_num_str {
          value = $input.num|substr:0:$end_pos
        }
        var $current_num {
          value = $current_num_str|to_int
        }
        
        // Check for leading zeros - skip if number has leading zero and is more than 1 digit
        var $current_str_len {
          value = $current_num_str|strlen
        }
        
        conditional {
          if (($current_str_len > 1) && ($current_num_str|substr:0:1 == "0")) {
            // Skip this - has leading zero
          }
          else {
            var $new_entry {
              value = {
                index: $end_pos,
                current_expr: $current_num_str,
                current_val: $current_num,
                last_operand: $current_num
              }
            }
            var $work_stack {
              value = $work_stack|merge:[$new_entry]
            }
          }
        }
      }
    }
    
    // Limit iterations to prevent infinite loops (safety)
    var $max_iterations {
      value = 10000
    }
    var $iteration_count {
      value = 0
    }
    
    // Process the stack iteratively
    while ((($work_stack|count) > 0) && ($iteration_count < $max_iterations)) {
      each {
        // Pop from stack
        var $state {
          value = $work_stack|last
        }
        var $work_stack {
          value = $work_stack|slice:0:(($work_stack|count) - 1)
        }
        
        var $idx {
          value = $state|get:"index"
        }
        var $expr {
          value = $state|get:"current_expr"
        }
        var $val {
          value = $state|get:"current_val"
        }
        var $last {
          value = $state|get:"last_operand"
        }
        
        // Check if we've reached the end
        conditional {
          if ($idx >= $num_len) {
            conditional {
              if ($val == $input.target) {
                var $results {
                  value = $results|merge:[$expr]
                }
              }
            }
          }
          else {
            // Try all possible next numbers starting from idx
            var $remaining_len {
              value = $num_len - $idx
            }
            
            for ($remaining_len) {
              each as $j {
                var $j_end_pos {
                  value = $idx + $j + 1
                }
                var $next_num_str {
                  value = $input.num|substr:$idx:$j_end_pos
                }
                var $next_num {
                  value = $next_num_str|to_int
                }
                
                // Check for leading zeros
                var $next_str_len {
                  value = $next_num_str|strlen
                }
                
                conditional {
                  if (($next_str_len > 1) && ($next_num_str|substr:0:1 == "0")) {
                    // Skip - has leading zero
                  }
                  else {
                    // Addition
                    var $add_expr {
                      value = $expr ~ "+" ~ $next_num_str
                    }
                    var $add_val {
                      value = $val + $next_num
                    }
                    var $add_entry {
                      value = {
                        index: $j_end_pos,
                        current_expr: $add_expr,
                        current_val: $add_val,
                        last_operand: $next_num
                      }
                    }
                    var $work_stack {
                      value = $work_stack|merge:[$add_entry]
                    }
                    
                    // Subtraction
                    var $sub_expr {
                      value = $expr ~ "-" ~ $next_num_str
                    }
                    var $sub_val {
                      value = $val - $next_num
                    }
                    var $sub_last {
                      value = -1 * $next_num
                    }
                    var $sub_entry {
                      value = {
                        index: $j_end_pos,
                        current_expr: $sub_expr,
                        current_val: $sub_val,
                        last_operand: $sub_last
                      }
                    }
                    var $work_stack {
                      value = $work_stack|merge:[$sub_entry]
                    }
                    
                    // Multiplication (need to handle precedence)
                    // current_val = current_val - last_operand + (last_operand * next_num)
                    var $mult_term {
                      value = $last * $next_num
                    }
                    var $mult_val {
                      value = $val - $last + $mult_term
                    }
                    var $mult_expr {
                      value = $expr ~ "*" ~ $next_num_str
                    }
                    var $mult_entry {
                      value = {
                        index: $j_end_pos,
                        current_expr: $mult_expr,
                        current_val: $mult_val,
                        last_operand: $mult_term
                      }
                    }
                    var $work_stack {
                      value = $work_stack|merge:[$mult_entry]
                    }
                  }
                }
              }
            }
          }
        }
        
        var $iteration_count {
          value = $iteration_count + 1
        }
      }
    }
    
    // Return the results
    return { value = $results }
  }
  
  response = $results
}
