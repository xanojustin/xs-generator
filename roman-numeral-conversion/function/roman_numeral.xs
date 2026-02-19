function "integer_to_roman" {
  description = "Convert an integer to a Roman numeral string"
  input {
    int number { description = "The integer to convert (1-3999)" }
  }
  stack {
    // Define the Roman numeral mappings (value to symbol)
    var $mappings {
      value = [
        {value: 1000, symbol: "M"},
        {value: 900, symbol: "CM"},
        {value: 500, symbol: "D"},
        {value: 400, symbol: "CD"},
        {value: 100, symbol: "C"},
        {value: 90, symbol: "XC"},
        {value: 50, symbol: "L"},
        {value: 40, symbol: "XL"},
        {value: 10, symbol: "X"},
        {value: 9, symbol: "IX"},
        {value: 5, symbol: "V"},
        {value: 4, symbol: "IV"},
        {value: 1, symbol: "I"}
      ]
    }

    // Initialize result string
    var $result {
      value = ""
    }

    // Initialize remaining value
    var $remaining {
      value = $input.number
    }

    // Iterate through each mapping
    foreach ($mappings) {
      each as $mapping {
        // Calculate how many times this symbol fits
        var $count {
          value = `$remaining / $mapping.value`
        }

        // Only process if count is at least 1
        conditional {
          if (`$count >= 1`) {
            // Create the repeated symbol string
            var $symbols {
              value = ""
            }

            // Build the symbol string by appending count times
            // Use a range to iterate the count number of times
            var $range_arr {
              value = `|range:1:$count`
            }

            foreach ($range_arr) {
              each as $_ {
                text.append $symbols {
                  value = $mapping.symbol
                }
              }
            }

            // Append symbols to result
            text.append $result {
              value = $symbols
            }

            // Subtract the value we've converted
            var $subtracted {
              value = `$count * $mapping.value`
            }
            math.sub $remaining {
              value = $subtracted
            }
          }
        }
      }
    }
  }
  response = $result
}
