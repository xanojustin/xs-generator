// Fraction to Recurring Decimal
// Given two integers numerator and denominator, return the fraction in string format.
// If the fractional part is repeating, enclose the repeating part in parentheses.
function "fraction_to_recurring_decimal" {
  description = "Converts a fraction to decimal string with repeating notation"
  
  input {
    int numerator { description = "The numerator of the fraction" }
    int denominator { description = "The denominator of the fraction" }
  }
  
  stack {
    // Handle zero numerator case
    conditional {
      if ($input.numerator == 0) {
        var $result { value = "0" }
      }
      else {
        // Determine sign
        var $negative { value = ($input.numerator < 0) != ($input.denominator < 0) }
        
        // Work with absolute values
        var $num { value = $input.numerator|abs }
        var $den { value = $input.denominator|abs }
        
        // Calculate integer part
        var $integer_part { value = $num / $den }
        var $remainder { value = $num % $den }
        
        // Build result string
        var $result { value = "" }
        
        // Add sign if negative
        conditional {
          if ($negative) {
            var $result { value = "-" }
          }
        }
        
        // Add integer part
        var $result { value = $result ~ ($integer_part|to_text) }
        
        // If remainder is 0, we're done (no fractional part)
        conditional {
          if ($remainder == 0) {
            // Result already contains integer part, nothing more to do
          }
          else {
            // Add decimal point
            var $result { value = $result ~ "." }
            
            // Map to track remainders and their positions in result
            var $remainder_map { value = {} }
            
            // Build fractional part
            var $fractional { value = "" }
            var $pos { value = 0 }
            var $found_repeating { value = false }
            var $repeating_result { value = "" }
            
            while ($remainder != 0 && !$found_repeating) {
              each {
                // Check if we've seen this remainder before (repeating pattern)
                var $remainder_key { value = $remainder|to_text }
                
                conditional {
                  if ($remainder_map|has:$remainder_key) {
                    // Found repeating pattern - get the start position
                    var $repeat_start { value = $remainder_map|get:$remainder_key }
                    
                    // Split fractional into non-repeating and repeating parts
                    var $non_repeat { value = $fractional|slice:0:$repeat_start }
                    var $repeat { value = $fractional|slice:$repeat_start:$pos }
                    
                    // Build final result with parentheses
                    var $repeating_result { value = $result ~ $non_repeat ~ "(" ~ $repeat ~ ")" }
                    var $found_repeating { value = true }
                  }
                }
                
                // Store current remainder and its position
                var $remainder_map { value = $remainder_map|set:$remainder_key:$pos }
                
                // Continue long division
                var $remainder { value = $remainder * 10 }
                var $digit { value = $remainder / $den }
                var $remainder { value = $remainder % $den }
                
                // Append digit to fractional part
                var $fractional { value = $fractional ~ ($digit|to_text) }
                var $pos { value = $pos + 1 }
              }
            }
            
            // Use repeating result if found, otherwise use non-repeating
            conditional {
              if ($found_repeating) {
                var $result { value = $repeating_result }
              }
              else {
                // No repeating pattern - append fractional part
                var $result { value = $result ~ $fractional }
              }
            }
          }
        }
      }
    }
  }
  
  response = $result
}
