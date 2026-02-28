// Halves Alike - Determine if String Halves Are Alike
// Given a string of even length, split it into two halves and check if
// both halves contain the same number of vowels (a, e, i, o, u, A, E, I, O, U)
function "halves_alike" {
  description = "Determines if both halves of a string have the same number of vowels"
  
  input {
    text s { description = "Input string of even length" }
  }
  
  stack {
    // Get the length and midpoint of the string
    var $len { value = $input.s|strlen }
    var $mid { value = $len / 2 }
    
    // Split into two halves
    var $first_half { value = $input.s|substr:0:$mid }
    var $second_half { value = $input.s|substr:$mid:$len }
    
    // Define vowels
    var $vowels { value = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"] }
    
    // Count vowels in first half
    var $first_count { value = 0 }
    var $i { value = 0 }
    
    while ($i < $mid) {
      each {
        var $char { value = $first_half|substr:$i:$i + 1 }
        conditional {
          if ($vowels|contains:$char) {
            var.update $first_count { value = $first_count + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Count vowels in second half
    var $second_count { value = 0 }
    var $j { value = 0 }
    
    while ($j < $mid) {
      each {
        var $char { value = $second_half|substr:$j:$j + 1 }
        conditional {
          if ($vowels|contains:$char) {
            var.update $second_count { value = $second_count + 1 }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Compare vowel counts
    var $are_alike { value = $first_count == $second_count }
  }
  
  response = $are_alike
}
