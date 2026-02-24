// Kids With Candies - Determine which kids can have the greatest number of candies
// if given all the extra candies
function "kidsWithCandies" {
  description = "Returns boolean array indicating which kids could have the most candies"

  input {
    int[] candies { description = "Array of candies each kid has" }
    int extraCandies { description = "Extra candies to distribute to one kid" }
  }

  stack {
    // Find the maximum candies any kid currently has
    var $maxCandies { value = 0 }
    var $i { value = 0 }

    while ($i < ($input.candies|count)) {
      each {
        conditional {
          if ($input.candies[$i] > $maxCandies) {
            var.update $maxCandies { value = $input.candies[$i] }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Determine which kids can have the greatest number of candies
    var $result { value = [] }
    var.update $i { value = 0 }

    while ($i < ($input.candies|count)) {
      each {
        conditional {
          if ($input.candies[$i] + $input.extraCandies >= $maxCandies) {
            var $result { value = $result|merge:[true] }
          }
          else {
            var $result { value = $result|merge:[false] }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $result
}
