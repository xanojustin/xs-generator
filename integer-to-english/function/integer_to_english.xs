function "integer_to_english" {
  description = "Convert a non-negative integer to its English words representation"
  input {
    int num filters=min:0 { description = "Non-negative integer to convert (0 to 2,147,483,647)" }
  }
  stack {
    // Define word mappings for ones, teens, and tens
    var $ones {
      value = [
        "Zero", "One", "Two", "Three", "Four", "Five",
        "Six", "Seven", "Eight", "Nine", "Ten",
        "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
        "Sixteen", "Seventeen", "Eighteen", "Nineteen"
      ]
    }
    var $tens {
      value = [
        "", "", "Twenty", "Thirty", "Forty", "Fifty",
        "Sixty", "Seventy", "Eighty", "Ninety"
      ]
    }
    
    // Handle zero specially - set result directly
    var $result { value = "" }
    
    conditional {
      if ($input.num == 0) {
        var $result { value = "Zero" }
      }
      else {
        // Process the number in chunks (billions, millions, thousands, remainder)
        var $n { value = $input.num }
        
        // Billions
        conditional {
          if ($n >= 1000000000) {
            var $billions { value = $n / 1000000000 }
            var $billions_int { value = $billions|to_int }
            function.run "convert_chunk" {
              input = { num: $billions_int, ones: $ones, tens: $tens }
            } as $billions_text
            var $result { value = $result ~ $billions_text ~ " Billion" }
            var $n { value = $n % 1000000000 }
            conditional {
              if ($n > 0) {
                var $result { value = $result ~ " " }
              }
            }
          }
        }
        
        // Millions
        conditional {
          if ($n >= 1000000) {
            var $millions { value = $n / 1000000 }
            var $millions_int { value = $millions|to_int }
            function.run "convert_chunk" {
              input = { num: $millions_int, ones: $ones, tens: $tens }
            } as $millions_text
            var $result { value = $result ~ $millions_text ~ " Million" }
            var $n { value = $n % 1000000 }
            conditional {
              if ($n > 0) {
                var $result { value = $result ~ " " }
              }
            }
          }
        }
        
        // Thousands
        conditional {
          if ($n >= 1000) {
            var $thousands { value = $n / 1000 }
            var $thousands_int { value = $thousands|to_int }
            function.run "convert_chunk" {
              input = { num: $thousands_int, ones: $ones, tens: $tens }
            } as $thousands_text
            var $result { value = $result ~ $thousands_text ~ " Thousand" }
            var $n { value = $n % 1000 }
            conditional {
              if ($n > 0) {
                var $result { value = $result ~ " " }
              }
            }
          }
        }
        
        // Remainder (less than 1000)
        conditional {
          if ($n > 0) {
            function.run "convert_chunk" {
              input = { num: $n, ones: $ones, tens: $tens }
            } as $remainder_text
            var $result { value = $result ~ $remainder_text }
          }
        }
      }
    }
  }
  response = $result
}
