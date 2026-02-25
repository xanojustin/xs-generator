// Height Checker - LeetCode 1051
// A school is trying to take an annual photo of all the students.
// The students are asked to stand in a single file line in non-decreasing order by height.
// Return the number of students that are not standing in the correct positions.
function "height_checker" {
  description = "Count students not in correct position when sorted by height"

  input {
    int[] heights { description = "Array of student heights in current order" }
  }

  stack {
    // Create a sorted copy of the heights array
    var $sorted_heights { value = $input.heights|sort }
    var $mismatch_count { value = 0 }
    var $index { value = 0 }

    // Iterate through the array and count mismatches
    foreach ($input.heights) {
      each as $height {
        conditional {
          if ($height != ($sorted_heights|index:$index)) {
            var $mismatch_count { value = $mismatch_count + 1 }
          }
        }
        var.update $index { value = $index + 1 }
      }
    }
  }

  response = $mismatch_count
}
