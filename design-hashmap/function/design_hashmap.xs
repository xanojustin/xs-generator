// Design HashMap - Data Structure Design Exercise
// Implements a basic hash map with put, get, and remove operations
// Uses separate chaining for collision resolution
function "design_hashmap" {
  description = "Design a HashMap with put, get, and remove operations"

  input {
    text operation { description = "Operation to perform: 'put', 'get', or 'remove'" }
    int key { description = "Key for the operation" }
    int value { description = "Value for put operation (optional)" }
    json hashmap { description = "Current state of the hashmap" }
  }

  stack {
    // Initialize hashmap if not provided
    var $map {
      value = $input.hashmap ?? { buckets: [], size: 0 }
    }

    // Ensure buckets array exists
    var $buckets {
      value = $map.buckets ?? []
    }

    // Calculate bucket index using simple hash function
    var $bucket_count { value = 1000 }
    var $index {
      value = $input.key % $bucket_count
    }

    // Handle negative indices
    conditional {
      if ($index < 0) {
        var $index { value = $index + $bucket_count }
      }
    }

    // Get or create bucket
    var $bucket {
      value = $buckets[$index] ?? []
    }

    // Find if key already exists in bucket
    var $found_index { value = -1 }
    var $found_value { value = -1 }

    // Search for key in bucket
    var $i { value = 0 }
    while ($i < $bucket|count) {
      each {
        var $entry { value = $bucket[$i] }
        conditional {
          if ($entry.key == $input.key) {
            var $found_index { value = $i }
            var $found_value { value = $entry.value }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Process based on operation
    var $result { value = -1 }
    var $new_bucket { value = $bucket }

    conditional {
      // PUT operation - insert or update
      if ($input.operation == "put") {
        conditional {
          if ($found_index >= 0) {
            // Update existing entry using slice and merge
            var $updated_entry {
              value = { key: $input.key, value: $input.value }
            }
            var $before {
              value = $bucket|slice:0:$found_index
            }
            var $after {
              value = $bucket|slice:($found_index + 1):($bucket|count)
            }
            var $new_bucket {
              value = $before|merge:[$updated_entry]|merge:$after
            }
          }
          else {
            // Add new entry
            var $new_entry {
              value = { key: $input.key, value: $input.value }
            }
            var $new_bucket {
              value = $bucket|merge:[$new_entry]
            }
          }
        }
        var $result { value = $input.value }
      }

      // GET operation - retrieve value
      elseif ($input.operation == "get") {
        conditional {
          if ($found_index >= 0) {
            var $result { value = $found_value }
          }
          else {
            var $result { value = -1 }
          }
        }
      }

      // REMOVE operation - delete key
      elseif ($input.operation == "remove") {
        conditional {
          if ($found_index >= 0) {
            // Remove entry at found_index
            var $before {
              value = $bucket|slice:0:$found_index
            }
            var $after {
              value = $bucket|slice:($found_index + 1):($bucket|count)
            }
            var $new_bucket {
              value = $before|merge:$after
            }
          }
        }
        var $result { value = true }
      }
    }

    // Update bucket in buckets array using slice and merge
    var $buckets_before {
      value = $buckets|slice:0:$index
    }
    var $buckets_after {
      value = $buckets|slice:($index + 1):($buckets|count)
    }
    var $new_buckets {
      value = $buckets_before|merge:[$new_bucket]|merge:$buckets_after
    }

    // Return updated hashmap state and result
    var $response_data {
      value = {
        hashmap: { buckets: $new_buckets, size: 0 },
        result: $result
      }
    }
  }

  response = $response_data
}
