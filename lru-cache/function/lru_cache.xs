// LRU Cache - Least Recently Used Cache implementation
// Classic data structure problem: cache with fixed capacity that evicts
// the least recently used item when capacity is exceeded
function "lru_cache" {
  description = "Implements an LRU Cache with get and put operations"

  input {
    int capacity { description = "Maximum number of items the cache can hold" }
    object[] operations {
      description = "Array of operations to perform on the cache"
      schema {
        text action { description = "Operation type: 'get' or 'put'" }
        text key { description = "Cache key" }
        int? value { description = "Value to store (required for put)" }
      }
    }
  }

  stack {
    // Cache storage: array of {key, value} objects
    // Most recently used is at the end of the array
    var $cache { value = [] }
    var $results { value = [] }

    foreach ($input.operations) {
      each as $op {
        conditional {
          // PUT operation: add or update a key-value pair
          if ($op.action == "put") {
            // Check if key already exists
            var $found_idx { value = -1 }
            var $idx { value = 0 }

            foreach ($cache) {
              each as $item {
                conditional {
                  if ($item.key == $op.key) {
                    var.update $found_idx { value = $idx }
                  }
                }
                var.update $idx { value = $idx + 1 }
              }
            }

            conditional {
              // Key exists: update value and move to end (most recent)
              if ($found_idx >= 0) {
                var $updated_item {
                  value = { key: $op.key, value: $op.value }
                }
                var $new_cache { value = [] }
                var $i { value = 0 }

                foreach ($cache) {
                  each as $item {
                    conditional {
                      if ($i != $found_idx) {
                        var.update $new_cache {
                          value = $new_cache|merge:[$item]
                        }
                      }
                    }
                    var.update $i { value = $i + 1 }
                  }
                }

                var.update $new_cache {
                  value = $new_cache|merge:[$updated_item]
                }
                var.update $cache { value = $new_cache }
              }
              // Key doesn't exist: add new item
              else {
                var $new_item {
                  value = { key: $op.key, value: $op.value }
                }

                // Check if we need to evict (at capacity)
                conditional {
                  if (($cache|count) >= $input.capacity) {
                    // Remove first item (least recently used)
                    var $evicted_cache { value = [] }
                    var $j { value = 0 }

                    foreach ($cache) {
                      each as $item {
                        conditional {
                          if ($j > 0) {
                            var.update $evicted_cache {
                              value = $evicted_cache|merge:[$item]
                            }
                          }
                        }
                        var.update $j { value = $j + 1 }
                      }
                    }
                    var.update $cache { value = $evicted_cache }
                  }
                }

                // Add new item to end
                var.update $cache {
                  value = $cache|merge:[$new_item]
                }
              }
            }

            // Record operation result
            var $op_result {
              value = { action: "put", key: $op.key, status: "success" }
            }
            var.update $results {
              value = $results|merge:[$op_result]
            }
          }

          // GET operation: retrieve value by key
          elseif ($op.action == "get") {
            var $found_value { value = null }
            var $found_index { value = -1 }
            var $search_idx { value = 0 }

            foreach ($cache) {
              each as $item {
                conditional {
                  if ($item.key == $op.key) {
                    var.update $found_value { value = $item.value }
                    var.update $found_index { value = $search_idx }
                  }
                }
                var.update $search_idx { value = $search_idx + 1 }
              }
            }

            // If found, move to end (most recently used)
            conditional {
              if ($found_index >= 0) {
                var $accessed_item {
                  value = {
                    key: $op.key,
                    value: $found_value
                  }
                }
                var $reordered_cache { value = [] }
                var $k { value = 0 }

                foreach ($cache) {
                  each as $item {
                    conditional {
                      if ($k != $found_index) {
                        var.update $reordered_cache {
                          value = $reordered_cache|merge:[$item]
                        }
                      }
                    }
                    var.update $k { value = $k + 1 }
                  }
                }

                var.update $reordered_cache {
                  value = $reordered_cache|merge:[$accessed_item]
                }
                var.update $cache { value = $reordered_cache }
              }
            }

            // Record operation result
            var $get_result {
              value = {
                action: "get",
                key: $op.key,
                value: $found_value
              }
            }
            var.update $results {
              value = $results|merge:[$get_result]
            }
          }
        }
      }
    }

    // Build final state
    var $final_keys { value = $cache|map:$$.key }
  }

  response = {
    operations: $results,
    final_cache_order: $final_keys,
    cache_contents: $cache
  }
}
