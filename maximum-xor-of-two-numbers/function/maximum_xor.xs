function "maximum_xor" {
  description = "Find the maximum XOR of any two numbers in an array using a bitwise trie"
  
  input {
    int[] nums {
      description = "Array of integers to find max XOR from"
    }
  }
  
  stack {
    // Edge case: empty array or single element
    conditional {
      if (($nums|count) <= 1) {
        return { value = 0 }
      }
    }
    
    // Find the maximum number to determine number of bits needed
    var $max_num { value = 0 }
    foreach ($nums) {
      each as $n {
        conditional {
          if ($n > $max_num) {
            var.update $max_num { value = $n }
          }
        }
      }
    }
    
    // Calculate number of bits needed (up to 31 for 32-bit positive integers)
    var $num_bits { value = 0 }
    var $temp { value = $max_num }
    conditional {
      if ($temp == 0) {
        var.update $num_bits { value = 1 }
      }
      else {
        while ($temp > 0) {
          each {
            var.update $temp { value = $temp / 2 }
            var.update $num_bits { value = $num_bits + 1 }
          }
        }
      }
    }
    
    // Ensure at least 1 bit and cap at 31 bits
    conditional {
      if ($num_bits < 1) {
        var.update $num_bits { value = 1 }
      }
      elseif ($num_bits > 31) {
        var.update $num_bits { value = 31 }
      }
    }
    
    // Initialize the trie as nested arrays
    // Each node is [child_for_0, child_for_1] where empty array means no child
    var $trie {
      value = [[], []]
    }
    
    // Track maximum XOR found
    var $max_xor { value = 0 }
    
    // Process each number
    foreach ($nums) {
      each as $num {
        // Build binary representation as array of bits (MSB first)
        var $bits { value = [] }
        for ($num_bits) {
          each as $i {
            // Calculate bit at position from MSB to LSB
            var $bit_pos { value = $num_bits - 1 - $i }
            var $divisor { value = 1 }
            
            // Calculate 2^bit_pos using loop
            for ($bit_pos) {
              each as $j {
                var.update $divisor { value = $divisor * 2 }
              }
            }
            
            // Get bit: (num / 2^pos) % 2
            var $bit_val { value = ($num / $divisor) % 2 }
            var.update $bits { value = $bits|push:$bit_val }
          }
        }
        
        // Insert into trie and find max XOR simultaneously
        var $node { value = $trie }
        var $xor_node { value = $trie }
        var $current_xor { value = 0 }
        
        foreach ($bits) {
          each as $bit {
            var $bit_int { value = $bit|to_int }
            var $opp_bit { value = 1 - $bit_int }
            
            // Check if we can go opposite way for max XOR
            conditional {
              if ($opp_bit == 0) {
                // Check if child 0 exists in xor_node
                conditional {
                  if ((($xor_node|first)|count) > 0) {
                    // Can take opposite path, add to XOR value
                    var.update $current_xor {
                      value = $current_xor * 2 + 1
                    }
                    var.update $xor_node { value = $xor_node|first }
                  }
                  else {
                    // Must take same path
                    var.update $current_xor {
                      value = $current_xor * 2
                    }
                    var.update $xor_node { value = $xor_node|last }
                  }
                }
              }
              else {
                // opp_bit == 1
                conditional {
                  if ((($xor_node|last)|count) > 0) {
                    // Can take opposite path
                    var.update $current_xor {
                      value = $current_xor * 2 + 1
                    }
                    var.update $xor_node { value = $xor_node|last }
                  }
                  else {
                    // Must take same path
                    var.update $current_xor {
                      value = $current_xor * 2
                    }
                    var.update $xor_node { value = $xor_node|first }
                  }
                }
              }
            }
            
            // Insert bit into trie - create child if doesn't exist
            conditional {
              if ($bit_int == 0) {
                conditional {
                  if ((($node|first)|count) == 0) {
                    var $new_child { value = [[], []] }
                    var $node_first { value = $node|first }
                    var $node_last { value = $node|last }
                    var.update $node { value = [$new_child, $node_last] }
                  }
                }
                var.update $node { value = $node|first }
              }
              else {
                conditional {
                  if ((($node|last)|count) == 0) {
                    var $new_child { value = [[], []] }
                    var $node_first { value = $node|first }
                    var $node_last { value = $node|last }
                    var.update $node { value = [$node_first, $new_child] }
                  }
                }
                var.update $node { value = $node|last }
              }
            }
          }
        }
        
        // Update max XOR
        conditional {
          if ($current_xor > $max_xor) {
            var.update $max_xor { value = $current_xor }
          }
        }
      }
    }
  }
  
  response = $max_xor
}
