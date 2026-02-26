function "reverse_string_ii" {
  description = "Reverse first k characters for every 2k characters in a string"
  input {
    text s
    int k filters=min:1
  }
  stack {
    var $chars { value = $input.s|split:"" }
    var $n { value = ($chars|count) }
    var $result_chars { value = [] }
    var $i { value = 0 }

    while ($i < $n) {
      each {
        var $chunk_end { value = ($i + $input.k - 1)|min:($n - 1) }
        var $j { value = $chunk_end }

        while ($j >= $i) {
          each {
            var $char { value = $chars|slice:$j:$j|first }
            var.update $result_chars { value = $result_chars|push:$char }
            var.update $j { value = $j - 1 }
          }
        }

        var $remaining_start { value = $i + $input.k }
        var $remaining_end { value = ($i + 2 * $input.k - 1)|min:($n - 1) }
        var $m { value = $remaining_start }

        while ($m <= $remaining_end && $m < $n) {
          each {
            var $char2 { value = $chars|slice:$m:$m|first }
            var.update $result_chars { value = $result_chars|push:$char2 }
            var.update $m { value = $m + 1 }
          }
        }

        var.update $i { value = $i + 2 * $input.k }
      }
    }
  }
  response = $result_chars|join:""
}
