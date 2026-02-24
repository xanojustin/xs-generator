// Keyboard Row - Check which words can be typed using only one keyboard row
// Returns words that can be typed using letters from only one row of a QWERTY keyboard
function "keyboard-row" {
  description = "Finds words that can be typed using only one row of a QWERTY keyboard"
  
  input {
    text[] words { description = "Array of words to check" }
  }
  
  stack {
    // Define the three rows of a QWERTY keyboard
    var $top_row { value = "qwertyuiop" }
    var $middle_row { value = "asdfghjkl" }
    var $bottom_row { value = "zxcvbnm" }
    
    // Result array for valid words
    var $result { value = [] }
    
    // Process each word
    var $word_index { value = 0 }
    while ($word_index < ($input.words|count)) {
      each {
        // Get current word and convert to lowercase
        var $word { value = $input.words[$word_index]|to_lower }
        
        // Determine which row the first character belongs to
        var $first_char { value = $word|slice:0:1 }
        
        // Check which row this word belongs to
        var $in_top { value = $top_row|contains:$first_char }
        var $in_middle { value = $middle_row|contains:$first_char }
        var $in_bottom { value = $bottom_row|contains:$first_char }
        
        // Determine target row
        var $target_row { value = "" }
        conditional {
          if ($in_top) {
            var $target_row { value = $top_row }
          }
          elseif ($in_middle) {
            var $target_row { value = $middle_row }
          }
          elseif ($in_bottom) {
            var $target_row { value = $bottom_row }
          }
        }
        
        // Check if all characters are in the target row
        var $valid { value = true }
        var $char_index { value = 0 }
        
        while ($char_index < ($word|strlen)) {
          each {
            var $char { value = $word|slice:$char_index:1 }
            var $char_in_row { value = $target_row|contains:$char }
            
            conditional {
              if (!$char_in_row) {
                var $valid { value = false }
              }
            }
            
            var.update $char_index { value = $char_index + 1 }
          }
        }
        
        // Add to result if valid
        conditional {
          if ($valid) {
            var $result { 
              value = $result|merge:[$input.words[$word_index]]
            }
          }
        }
        
        var.update $word_index { value = $word_index + 1 }
      }
    }
  }
  
  response = $result
}
