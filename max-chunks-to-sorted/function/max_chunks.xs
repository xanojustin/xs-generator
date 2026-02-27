// Max Chunks To Sorted
// Given an array arr that is a permutation of [0, 1, ..., arr.length - 1],
// split it into the maximum number of "chunks" (partitions) such that
// individually sorting each chunk and concatenating results in the sorted array.
function "max_chunks" {
  description = "Finds the maximum number of chunks to make sorted"
  
  input {
    int[] arr
  }
  
  stack {
    var $chunks { value = 0 }
    var $max_so_far { value = -1 }
    var $i { value = 0 }
    
    while ($i < ($input.arr|count)) {
      each {
        var $current { value = $input.arr[$i] }
        
        conditional {
          if ($current > $max_so_far) {
            var.update $max_so_far { value = $current }
          }
        }
        
        conditional {
          if ($max_so_far == $i) {
            var.update $chunks { value = $chunks + 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $chunks
}
