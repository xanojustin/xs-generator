// Integer to Roman conversion
// Converts an integer to its Roman numeral representation
function "integer-to-roman" {
  description = "Convert an integer to a Roman numeral"
  
  input {
    int number { description = "The integer to convert (1-3999)" }
  }
  
  stack {
    var $result { value = "" }
    var $remaining { value = $input.number }
    
    // Process 1000s (M)
    while ($remaining >= 1000) {
      each {
        var.update $result { value = $result ~ "M" }
        var.update $remaining { value = $remaining - 1000 }
      }
    }
    
    // Process 900s (CM)
    while ($remaining >= 900) {
      each {
        var.update $result { value = $result ~ "CM" }
        var.update $remaining { value = $remaining - 900 }
      }
    }
    
    // Process 500s (D)
    while ($remaining >= 500) {
      each {
        var.update $result { value = $result ~ "D" }
        var.update $remaining { value = $remaining - 500 }
      }
    }
    
    // Process 400s (CD)
    while ($remaining >= 400) {
      each {
        var.update $result { value = $result ~ "CD" }
        var.update $remaining { value = $remaining - 400 }
      }
    }
    
    // Process 100s (C)
    while ($remaining >= 100) {
      each {
        var.update $result { value = $result ~ "C" }
        var.update $remaining { value = $remaining - 100 }
      }
    }
    
    // Process 90s (XC)
    while ($remaining >= 90) {
      each {
        var.update $result { value = $result ~ "XC" }
        var.update $remaining { value = $remaining - 90 }
      }
    }
    
    // Process 50s (L)
    while ($remaining >= 50) {
      each {
        var.update $result { value = $result ~ "L" }
        var.update $remaining { value = $remaining - 50 }
      }
    }
    
    // Process 40s (XL)
    while ($remaining >= 40) {
      each {
        var.update $result { value = $result ~ "XL" }
        var.update $remaining { value = $remaining - 40 }
      }
    }
    
    // Process 10s (X)
    while ($remaining >= 10) {
      each {
        var.update $result { value = $result ~ "X" }
        var.update $remaining { value = $remaining - 10 }
      }
    }
    
    // Process 9s (IX)
    while ($remaining >= 9) {
      each {
        var.update $result { value = $result ~ "IX" }
        var.update $remaining { value = $remaining - 9 }
      }
    }
    
    // Process 5s (V)
    while ($remaining >= 5) {
      each {
        var.update $result { value = $result ~ "V" }
        var.update $remaining { value = $remaining - 5 }
      }
    }
    
    // Process 4s (IV)
    while ($remaining >= 4) {
      each {
        var.update $result { value = $result ~ "IV" }
        var.update $remaining { value = $remaining - 4 }
      }
    }
    
    // Process 1s (I)
    while ($remaining >= 1) {
      each {
        var.update $result { value = $result ~ "I" }
        var.update $remaining { value = $remaining - 1 }
      }
    }
  }
  
  response = $result
}
