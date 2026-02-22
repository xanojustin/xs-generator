function "ransom_note" {
  description = "Check if ransom note can be constructed from magazine letters"
  input {
    text ransom_note filters=trim { description = "The ransom note string to construct" }
    text magazine filters=trim { description = "The magazine string to use as source" }
  }
  stack {
    // Handle empty ransom note - can always be constructed
    conditional {
      if ($input.ransom_note == "") {
        return { value = true }
      }
    }

    // Count available letters in magazine
    var $magazine_counts { value = {} }
    var $magazine_chars { value = $input.magazine|split:"" }
    
    foreach ($magazine_chars) {
      each as $char {
        conditional {
          if ($char != "") {
            var $current_count {
              value = $magazine_counts|get:$char:0
            }
            var.update $magazine_counts {
              value = $magazine_counts|set:$char:($current_count + 1)
            }
          }
        }
      }
    }

    // Check if ransom note can be constructed
    var $ransom_chars { value = $input.ransom_note|split:"" }
    var $can_construct { value = true }

    foreach ($ransom_chars) {
      each as $char {
        conditional {
          if ($char != "") {
            var $available {
              value = $magazine_counts|get:$char:0
            }
            conditional {
              if ($available == 0) {
                // Letter not available or exhausted
                var.update $can_construct { value = false }
              }
              else {
                // Use one letter
                var.update $magazine_counts {
                  value = $magazine_counts|set:$char:($available - 1)
                }
              }
            }
          }
        }
      }
    }
  }
  response = $can_construct
}
