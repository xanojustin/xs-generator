function "shuffle_array" {
  description = "Shuffles an array using the Fisher-Yates algorithm"
  input {
    int[] nums
  }
  stack {
    var $arr { value = $input.nums }
    var $n { value = $arr|count }
    var $i { value = $n - 1 }

    while ($i > 0) {
      each {
        // Generate random index from 0 to i using timestamp-based approach
        var $timestamp { value = now|format_timestamp:"U":"UTC"|to_int }
        var $j { value = ($timestamp % ($i + 1)) }
        var $temp { value = $arr|get:$i }
        var.update $arr { value = $arr|set:$i:($arr|get:$j) }
        var.update $arr { value = $arr|set:$j:$temp }
        var.update $i { value = $i - 1 }
      }
    }
  }
  response = $arr
}
