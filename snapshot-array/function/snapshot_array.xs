// Snapshot Array - Design a data structure that supports array operations with snapshots
// LeetCode #1146 - Implement a SnapshotArray that supports set, snap, and get operations
function "snapshot_array" {
  description = "Implements SnapshotArray with set, snap, and get operations"
  
  input {
    int length { description = "Length of the array" }
    object[] operations {
      description = "Array of operations to perform"
      schema {
        text op { description = "Operation type: 'set', 'snap', or 'get'" }
        int? index { description = "Index for set/get operations" }
        int? val { description = "Value for set operation" }
        int? snap_id { description = "Snapshot ID for get operation" }
      }
    }
  }
  
  stack {
    // Use an object to store array data - key is index, value is history of [snap_id, value]
    // This avoids the need for array element updates
    var $data { value = {} }
    
    // Initialize each element with history containing default value
    var $i { value = 0 }
    while ($i < $input.length) {
      each {
        // Create the key as text
        var $key_str { value = $i|to_text }
        // Build the update object with the dynamic key
        var $new_entry { value = {} }
        var $new_entry {
          value = $new_entry|merge_recursive:{
            $key_str: [{ snap_id: -1, value: 0 }]
          }
        }
        var $data {
          value = $data|merge:$new_entry
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Current snapshot ID
    var $snap_id { value = 0 }
    
    // Results of get operations
    var $results { value = [] }
    
    // Process each operation
    foreach ($input.operations) {
      each as $op {
        switch ($op.op) {
          case ("set") {
            // Get the index as text for object key access
            var $idx_key { value = $op.index|to_text }
            var $history { value = $data.$idx_key }
            
            // Get last entry to check if we need to update or add
            var $last_entry { value = $history|last }
            
            conditional {
              if ($last_entry.snap_id == $snap_id) {
                // Update the last entry - need to rebuild history
                // Remove last entry and add updated one
                var $history_count { value = $history|count }
                var $new_count { value = $history_count - 1 }
                var $history_without_last {
                  value = $history|slice:0:$new_count
                }
                var $new_entry_val {
                  value = { snap_id: $snap_id, value: $op.val }
                }
                var $history {
                  value = $history_without_last|merge:[$new_entry_val]
                }
              }
              else {
                // Add new entry to history
                var $new_entry_val {
                  value = { snap_id: $snap_id, value: $op.val }
                }
                var $history {
                  value = $history|merge:[$new_entry_val]
                }
              }
            }
            
            // Update data with new history
            var $data_update { value = {} }
            var $data_update {
              value = $data_update|merge_recursive:{
                $idx_key: $history
              }
            }
            var $data {
              value = $data|merge:$data_update
            }
          } break
          
          case ("snap") {
            var.update $snap_id { value = $snap_id + 1 }
          } break
          
          case ("get") {
            // Get the history for this index
            var $idx_key { value = $op.index|to_text }
            var $history { value = $data.$idx_key }
            
            // Binary search to find the right value for the snap_id
            var $left { value = 0 }
            var $right {
              value = ($history|count) - 1
            }
            var $result { value = 0 }
            
            while ($left <= $right) {
              each {
                var $mid {
                  value = ($left + $right) / 2
                }
                var $entry {
                  value = $history[$mid]
                }
                
                conditional {
                  if ($entry.snap_id <= $op.snap_id) {
                    var $result { value = $entry.value }
                    var $left { value = $mid + 1 }
                  }
                  else {
                    var $right { value = $mid - 1 }
                  }
                }
              }
            }
            
            // Add result to results array
            var $results {
              value = $results|merge:[$result]
            }
          } break
        }
      }
    }
  }
  
  response = $results
}