function "raindrops" {
  description = "Convert a number to raindrop sounds based on its factors"
  input {
    int number filters=min:1
  }
  stack {
    var $result { value = "" }
    
    conditional {
      if (($input.number % 3) == 0) {
        var.update $result { value = $result ~ "Pling" }
      }
    }
    
    conditional {
      if (($input.number % 5) == 0) {
        var.update $result { value = $result ~ "Plang" }
      }
    }
    
    conditional {
      if (($input.number % 7) == 0) {
        var.update $result { value = $result ~ "Plong" }
      }
    }
    
    conditional {
      if ($result == "") {
        var.update $result { value = $input.number|to_text }
      }
    }
  }
  response = $result
}
