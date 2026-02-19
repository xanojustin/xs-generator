function "merge_sorted_arrays" {
  description = "Merge two sorted arrays into a single sorted array"
  input {
    int[] array1
    int[] array2
  }
  stack {
    // Initialize pointers for both arrays
    var $i { value = 0 }
    var $j { value = 0 }
    var $result { value = [] }

    // Get lengths of both arrays
    var $len1 { value = $input.array1|count }
    var $len2 { value = $input.array2|count }

    // Merge while both arrays have elements
    while ($i < $len1 && $j < $len2) {
      each {
        conditional {
          if ($input.array1[$i] <= $input.array2[$j]) {
            array.push $result {
              value = $input.array1[$i]
            }
            math.add $i { value = 1 }
          }
          else {
            array.push $result {
              value = $input.array2[$j]
            }
            math.add $j { value = 1 }
          }
        }
      }
    }

    // Add remaining elements from array1
    while ($i < $len1) {
      each {
        array.push $result {
          value = $input.array1[$i]
        }
        math.add $i { value = 1 }
      }
    }

    // Add remaining elements from array2
    while ($j < $len2) {
      each {
        array.push $result {
          value = $input.array2[$j]
        }
        math.add $j { value = 1 }
      }
    }
  }
  response = $result
}
