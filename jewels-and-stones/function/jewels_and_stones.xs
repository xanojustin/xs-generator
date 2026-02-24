function "jewels_and_stones" {
  description = "Count how many stones are also jewels"
  input {
    text jewels { description = "String of unique jewel characters" }
    text stones { description = "String of stone characters to check" }
  }
  stack {
    var $count { value = 0 }
    var $jewel_array { value = $input.jewels|split:"" }
    var $stone_array { value = $input.stones|split:"" }
    
    foreach ($stone_array) {
      each as $stone {
        var $is_jewel { value = false }
        
        foreach ($jewel_array) {
          each as $jewel {
            conditional {
              if ($stone == $jewel) {
                var $is_jewel { value = true }
              }
            }
          }
        }
        
        conditional {
          if ($is_jewel) {
            var.update $count { value = $count + 1 }
          }
        }
      }
    }
  }
  response = $count
}
