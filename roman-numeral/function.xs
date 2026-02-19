function "roman-numeral" {
  description = "Convert an integer to a Roman numeral string"
  input {
    int number filters=min:1|max:3999 {
      description = "The integer to convert (1-3999, standard Roman numeral range)"
    }
  }
  stack {
    // Define the Roman numeral values and symbols in descending order
    var $values { value = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1] }
    var $symbols { value = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"] }
    
    var $result { value = "" }
    var $num { value = $input.number }
    var $i { value = 0 }
    
    while ($i < ($values|count)) {
      each {
        // Get current value and symbol
        var $current_value { value = $values|get:$i }
        var $current_symbol { value = $symbols|get:$i }
        
        // While we can subtract this value, do so and append the symbol
        while ($num >= $current_value) {
          each {
            var.update $result { value = $result ~ $current_symbol }
            var.update $num { value = $num - $current_value }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
