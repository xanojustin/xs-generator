function "number_complement" {
  description = "Calculate the complement of a positive integer by flipping all bits"
  input {
    int num filters=min:1
  }
  stack {
    // Find the number of bits needed to represent the number
    // We need to find the position of the highest set bit
    var $n {
      value = $input.num
    }
    var $bit_count {
      value = 0
    }

    // Count bits needed by dividing by 2 until we reach 0
    while ($n > 0) {
      each {
        math.add $bit_count {
          value = 1
        }
        // Integer division by 2
        var $n {
          value = $n / 2
        }
      }
    }

    // Create mask with all 1s (2^bit_count - 1)
    var $mask {
      value = 1
    }
    for ($bit_count) {
      each as $i {
        math.mul $mask {
          value = 2
        }
      }
    }
    math.sub $mask {
      value = 1
    }

    // Calculate complement: mask - num (since mask is all 1s)
    var $result {
      value = $mask - $input.num
    }
  }
  response = $result
}
