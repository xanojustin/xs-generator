function "move_zeroes" {
  description = "Move all zeros to the end of the array while maintaining the relative order of non-zero elements"
  input {
    int[] nums {
      description = "Array of integers that may contain zeros"
    }
  }
  stack {
    var $nums { value = $input.nums }
    var $n { value = $nums|count }
    var $insert_pos { value = 0 }
    var $i { value = 0 }

    // First pass: move all non-zero elements to the front
    while ($i < $n) {
      each {
        var $current { value = $nums|get:$i }
        conditional {
          if ($current != 0) {
            var $updated_nums { value = $nums|set:$insert_pos:$current }
            var.update $nums { value = $updated_nums }
            var.update $insert_pos { value = $insert_pos + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Second pass: fill remaining positions with zeros
    var $j { value = $insert_pos }
    while ($j < $n) {
      each {
        var $updated_nums { value = $nums|set:$j:0 }
        var.update $nums { value = $updated_nums }
        var.update $j { value = $j + 1 }
      }
    }
  }
  response = $nums
}
