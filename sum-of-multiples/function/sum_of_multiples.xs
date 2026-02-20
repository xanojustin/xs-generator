// Sum of Multiples - Sum all multiples of 3 or 5 below a given number
// Classic mathematical exercise similar to Project Euler Problem 1
function "sum_of_multiples" {
  description = "Calculates the sum of all multiples of 3 or 5 below the given limit"

  input {
    int limit { description = "Upper bound (exclusive) - sum all multiples below this number" }
  }

  stack {
    var $sum { value = 0 }
    var $i { value = 1 }

    while ($i < $input.limit) {
      each {
        conditional {
          // Check if divisible by 3 or 5
          if ((`$i % 3 == 0`) || (`$i % 5 == 0`)) {
            var.update $sum { value = $sum + $i }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $sum
}
