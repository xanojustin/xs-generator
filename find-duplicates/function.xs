function "find_duplicates" {
  description = "Find all duplicate elements in an array"
  input {
    int[] numbers {
      description = "Array of integers to check for duplicates"
    }
  }
  stack {
    var $seen { value = [] }
    var $duplicates { value = [] }

    foreach ($input.numbers) {
      each as $num {
        conditional {
          if ($seen|contains:$num) {
            // Only add to duplicates if not already there
            conditional {
              if (!($duplicates|contains:$num)) {
                var.update $duplicates { value = $duplicates|push:$num }
              }
            }
          }
          else {
            var.update $seen { value = $seen|push:$num }
          }
        }
      }
    }
  }
  response = $duplicates
}
