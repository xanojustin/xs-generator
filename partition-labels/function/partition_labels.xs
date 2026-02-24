// Partition Labels - String partitioning problem
// Given a string s, partition it into as many parts as possible so that each letter appears in at most one part
// Returns the sizes of the partitions
function "partition_labels" {
  description = "Partitions string so each letter appears in at most one part"
  
  input {
    text s { description = "String to partition" }
  }
  
  stack {
    // Handle empty string edge case
    conditional {
      if (($input.s|strlen) == 0) {
        var $result { value = [] }
      }
      else {
        // First pass: find last occurrence of each character
        var $last_occurrence { value = {} }
        var $chars { value = $input.s|split:"" }
        var $i { value = 0 }
        
        while ($i < ($chars|count)) {
          each {
            var $char { value = $chars[$i] }
            var $last_occurrence {
              value = $last_occurrence|set:($char|to_text):$i
            }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Second pass: find partition points
        var $partitions { value = [] }
        var $start { value = 0 }
        var $end { value = 0 }
        var $j { value = 0 }
        
        while ($j < ($chars|count)) {
          each {
            var $char { value = $chars[$j] }
            var $char_last { value = $last_occurrence|get:($char|to_text) }
            
            // Update the farthest boundary for current partition
            conditional {
              if ($char_last > $end) {
                var $end { value = $char_last }
              }
            }
            
            // If we reached the end of current partition, make a cut
            conditional {
              if ($j == $end) {
                var $partition_size { value = $end - $start + 1 }
                var $partitions { value = $partitions|merge:[$partition_size] }
                var $start { value = $end + 1 }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        var $result { value = $partitions }
      }
    }
  }
  
  response = $result
}
