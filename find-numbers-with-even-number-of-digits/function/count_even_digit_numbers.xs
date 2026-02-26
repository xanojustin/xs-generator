// Find Numbers with Even Number of Digits
// Given an array of integers, returns the count of numbers
// that have an even number of digits
function "count_even_digit_numbers" {
  description = "Counts numbers with even number of digits"
  
  input {
    int[] nums { description = "Array of integers to analyze" }
  }
  
  stack {
    var $count { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        // Convert number to text and count digits
        var $digits { value = ($num|abs|to_text)|strlen }
        
        // Check if digit count is even
        conditional {
          if (`$digits % 2 == 0`) {
            var.update $count { value = $count + 1 }
          }
        }
      }
    }
  }
  
  response = $count
}
