function "count_odd_numbers" {
  description = "Count odd numbers in an inclusive range [low, high]"
  
  input {
    int low { description = "Lower bound of the range (inclusive)" }
    int high { description = "Upper bound of the range (inclusive)" }
  }
  
  stack {
    // Formula: count of odd numbers in range [low, high]
    // If low is odd, include it; if high is odd, include it
    // Total = ((high + 1) // 2) - (low // 2)
    
    var $high_adjusted { value = ($input.high + 1) / 2 }
    var $low_adjusted { value = $input.low / 2 }
    var $count { value = $high_adjusted - $low_adjusted }
  }
  
  response = $count
}