function "get_left_height" {
  description = "Calculate the left height of tree starting at given index"
  input {
    int[] tree
    int index
  }
  stack {
    var $height { value = 0 }
    var $current_idx { value = $input.index }

    // Keep going left until out of bounds
    while ($current_idx < ($input.tree|count)) {
      each {
        var.update $height { value = $height + 1 }
        var.update $current_idx { value = (2 * $current_idx) + 1 }
      }
    }
  }
  response = $height
}
