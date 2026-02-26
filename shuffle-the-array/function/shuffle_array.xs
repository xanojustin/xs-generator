// Shuffle the Array - Array manipulation exercise
// Given an array nums of 2n elements [x1,x2,...,xn,y1,y2,...,yn],
// returns the array in the form [x1,y1,x2,y2,...,xn,yn]
function "shuffle_array" {
  description = "Shuffles an array by interleaving elements from first and second halves"

  input {
    int[] nums { description = "Array of 2n elements to shuffle" }
    int n { description = "Half the length of the array (number of element pairs)" }
  }

  stack {
    var $result { value = [] }
    var $i { value = 0 }

    while ($i < $input.n) {
      each {
        // Add element from first half (xi)
        var $first_half { value = $input.nums|slice:$i:($i + 1) }
        var $x { value = $first_half|first }
        var $result { value = $result|merge:[$x] }

        // Add element from second half (yi)
        var $second_index { value = $input.n + $i }
        var $second_half { value = $input.nums|slice:$second_index:($second_index + 1) }
        var $y { value = $second_half|first }
        var $result { value = $result|merge:[$y] }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $result
}
