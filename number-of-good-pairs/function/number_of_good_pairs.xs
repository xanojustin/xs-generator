// Number of Good Pairs
// Given an array of integers, count pairs (i,j) where nums[i] == nums[j] and i < j
function "number_of_good_pairs" {
  description = "Counts good pairs in an array where elements are equal"

  input {
    int[] nums { description = "Array of integers" }
  }

  stack {
    var $count { value = 0 }
    var $i { value = 0 }

    while ($i < $input.nums|count) {
      each {
        var $j { value = $i + 1 }

        while ($j < $input.nums|count) {
          each {
            conditional {
              if ($input.nums[$i] == $input.nums[$j]) {
                var $count { value = $count + 1 }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $count
}
