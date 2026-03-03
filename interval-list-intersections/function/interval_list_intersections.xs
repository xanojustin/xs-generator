function "interval_list_intersections" {
  input {
    object first_list {
      schema {
        json intervals
      }
    }
    object second_list {
      schema {
        json intervals
      }
    }
  }

  stack {
    var $first { value = $input.first_list.intervals }
    var $second { value = $input.second_list.intervals }
    var $result { value = [] }
    var $i { value = 0 }
    var $j { value = 0 }

    while (($i < ($first|count)) && ($j < ($second|count))) {
      each {
        var $first_interval { value = $first[$i] }
        var $second_interval { value = $second[$j] }
        var $first_start { value = $first_interval|get:"0" }
        var $first_end { value = $first_interval|get:"1" }
        var $second_start { value = $second_interval|get:"0" }
        var $second_end { value = $second_interval|get:"1" }

        conditional {
          if ($first_start > $second_start) {
            var $start { value = $first_start }
          }
          else {
            var $start { value = $second_start }
          }
        }

        conditional {
          if ($first_end < $second_end) {
            var $end { value = $first_end }
          }
          else {
            var $end { value = $second_end }
          }
        }

        conditional {
          if ($start <= $end) {
            var $intersection { value = [$start, $end] }
            var.update $result { value = $result|append:$intersection }
          }
        }

        conditional {
          if ($first_end < $second_end) {
            var.update $i { value = $i + 1 }
          }
          else {
            var.update $j { value = $j + 1 }
          }
        }
      }
    }
  }

  response = $result
}
