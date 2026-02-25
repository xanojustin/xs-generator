function "shortest_word_distance" {
  description = "Find the shortest distance between two words in an array"
  input {
    text[] words
    text word1
    text word2
  }
  stack {
    var $index1 { value = -1 }
    var $index2 { value = -1 }
    var $min_distance { value = ($input.words|count) }
    var $i { value = 0 }

    foreach ($input.words) {
      each as $word {
        conditional {
          if ($word == $input.word1) {
            var.update $index1 { value = $i }
          }
          elseif ($word == $input.word2) {
            var.update $index2 { value = $i }
          }
        }

        conditional {
          if ($index1 >= 0 && $index2 >= 0) {
            var $distance {
              value = $index1 - $index2
            }
            conditional {
              if ($distance < 0) {
                var.update $distance { value = 0 - $distance }
              }
            }
            conditional {
              if ($distance < $min_distance) {
                var.update $min_distance { value = $distance }
              }
            }
          }
        }

        math.add $i { value = 1 }
      }
    }
  }
  response = $min_distance
}
