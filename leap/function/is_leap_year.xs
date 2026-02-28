// Leap Year - Classic coding exercise
// Determines if a given year is a leap year
// Rules: Divisible by 4, except if divisible by 100 unless also divisible by 400
function "is_leap_year" {
  description = "Determines if a given year is a leap year"
  
  input {
    int year { description = "The year to check" }
  }
  
  stack {
    conditional {
      if (`$input.year % 400 == 0`) {
        var $is_leap { value = true }
      }
      elseif (`$input.year % 100 == 0`) {
        var $is_leap { value = false }
      }
      elseif (`$input.year % 4 == 0`) {
        var $is_leap { value = true }
      }
      else {
        var $is_leap { value = false }
      }
    }
  }
  
  response = $is_leap
}
