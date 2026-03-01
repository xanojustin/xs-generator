function "get_right_height" {
  description = "Calculate the right height of tree starting at given index"
  input {
    int[] tree
    int index
  }
  stack {
    var $height { value = 0 }
    var $current_idx { value = $input.index }

    // Keep going right until out of bounds
    while ($current_idx < ($input.tree|count)) {
      each {
        var.update $height { value = $height + 1 }
        var.update $current_idx { value = (2 * $current_idx) + 2 }
      }
    }
  }
  response = $height
}
