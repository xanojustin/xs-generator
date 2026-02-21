function "intersection" {
  description = "Find the intersection of two arrays - returns unique elements present in both arrays"

  input {
    int[] array1 { description = "First array of integers" }
    int[] array2 { description = "Second array of integers" }
  }

  stack {
    // Handle empty arrays - return empty result
    conditional {
      if (($input.array1|count) == 0 || ($input.array2|count) == 0) {
        return { value = [] }
      }
    }

    // Use the smaller array for iteration efficiency
    var $result { value = [] }
    var $set2 { value = $input.array2 }

    // Iterate through array1 and check if each element exists in array2
    foreach ($input.array1) {
      each as $element {
        // Check if element exists in array2 and not already in result
        conditional {
          if ($set2|contains:$element && !($result|contains:$element)) {
            var.update $result { value = $result|push:$element }
          }
        }
      }
    }
  }

  response = $result
}
