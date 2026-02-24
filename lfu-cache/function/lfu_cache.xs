// LFU Cache - Least Frequently Used Cache implementation
// Design and implement a data structure for LFU cache with O(1) operations
// When cache is full, evicts the least frequently used item
// If there's a tie, evict the least recently used among them
function "lfu_cache" {
  description = "Implements an LFU Cache with get and put operations"

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
    // Cache storage using arrays to track keys, values, frequencies, and access times
    var $keys { value = [] }
    var $values { value = [] }
    var $frequencies { value = [] }
    var $access_times { value = [] }
    var $time_counter { value = 0 }
    var $results { value = [] }

    foreach ($input.operations) {
      each as $op {
        var.update $time_counter { value = $time_counter + 1 }

        conditional {
          // PUT operation
          if ($op.action == "put") {
            var $found_idx { value = -1 }
            var $idx { value = 0 }

            // Find if key already exists
            foreach ($keys) {
              each as $k {
                conditional {
                  if ($k == $op.key) {
                    var.update $found_idx { value = $idx }
                  }
                }
                var.update $idx { value = $idx + 1 }
              }
            }

            conditional {
              // Key exists: update value and increment frequency
              if ($found_idx >= 0) {
                // Rebuild arrays to update at specific index
                var $new_values { value = [] }
                var $new_freqs { value = [] }
                var $new_times { value = [] }
                var $up_idx { value = 0 }

                foreach ($values) {
                  each as $v {
                    conditional {
                      if ($up_idx == $found_idx) {
                        var.update $new_values { value = $new_values|merge:[$op.value] }
                        var $old_freq { value = $frequencies|get:$found_idx:0 }
                        var.update $new_freqs { value = $new_freqs|merge:[($old_freq + 1)] }
                        var.update $new_times { value = $new_times|merge:[$time_counter] }
                      }
                      else {
                        var.update $new_values { value = $new_values|merge:[$v] }
                        var.update $new_freqs { value = $new_freqs|merge:[$frequencies|get:$up_idx:0] }
                        var.update $new_times { value = $new_times|merge:[$access_times|get:$up_idx:0] }
                      }
                    }
                    var.update $up_idx { value = $up_idx + 1 }
                  }
                }

                var.update $values { value = $new_values }
                var.update $frequencies { value = $new_freqs }
                var.update $access_times { value = $new_times }
              }
              // Key doesn't exist: add new item
              else {
                // Check if we need to evict
                conditional {
                  if (($keys|count) >= $input.capacity) {
                    // Find minimum frequency
                    var $min_freq { value = 999999 }
                    foreach ($frequencies) {
                      each as $f {
                        conditional {
                          if ($f < $min_freq) {
                            var.update $min_freq { value = $f }
                          }
                        }
                      }
                    }

                    // Find all items with minimum frequency
                    var $candidates { value = [] }
                    var $c_idx { value = 0 }
                    foreach ($frequencies) {
                      each as $f {
                        conditional {
                          if ($f == $min_freq) {
                            var $candidate {
                              value = {
                                index: $c_idx,
                                time: $access_times|get:$c_idx:0
                              }
                            }
                            var.update $candidates {
                              value = $candidates|merge:[$candidate]
                            }
                          }
                        }
                        var.update $c_idx { value = $c_idx + 1 }
                      }
                    }

                    // Find the oldest (smallest time) among candidates
                    var $evict_idx { value = -1 }
                    var $oldest_time { value = 999999 }
                    foreach ($candidates) {
                      each as $cand {
                        conditional {
                          if ($cand.time < $oldest_time) {
                            var.update $oldest_time { value = $cand.time }
                            var.update $evict_idx { value = $cand.index }
                          }
                        }
                      }
                    }

                    // Remove the evicted item from all arrays
                    conditional {
                      if ($evict_idx >= 0) {
                        var $new_keys { value = [] }
                        var $new_values { value = [] }
                        var $new_freqs { value = [] }
                        var $new_times { value = [] }
                        var $e_idx { value = 0 }

                        foreach ($keys) {
                          each as $k {
                            conditional {
                              if ($e_idx != $evict_idx) {
                                var.update $new_keys {
                                  value = $new_keys|merge:[$k]
                                }
                                var.update $new_values {
                                  value = $new_values|merge:[$values|get:$e_idx:0]
                                }
                                var.update $new_freqs {
                                  value = $new_freqs|merge:[$frequencies|get:$e_idx:0]
                                }
                                var.update $new_times {
                                  value = $new_times|merge:[$access_times|get:$e_idx:0]
                                }
                              }
                            }
                            var.update $e_idx { value = $e_idx + 1 }
                          }
                        }

                        var.update $keys { value = $new_keys }
                        var.update $values { value = $new_values }
                        var.update $frequencies { value = $new_freqs }
                        var.update $access_times { value = $new_times }
                      }
                    }
                  }
                }

                // Add new item
                var.update $keys {
                  value = $keys|merge:[$op.key]
                }
                var.update $values {
                  value = $values|merge:[$op.value]
                }
                var.update $frequencies {
                  value = $frequencies|merge:[1]
                }
                var.update $access_times {
                  value = $access_times|merge:[$time_counter]
                }
              }
            }

            // Record result
            var $put_result {
              value = { action: "put", key: $op.key, status: "success" }
            }
            var.update $results {
              value = $results|merge:[$put_result]
            }
          }

          // GET operation
          elseif ($op.action == "get") {
            var $found_idx { value = -1 }
            var $found_value { value = null }
            var $g_idx { value = 0 }

            foreach ($keys) {
              each as $k {
                conditional {
                  if ($k == $op.key) {
                    var.update $found_idx { value = $g_idx }
                    var.update $found_value {
                      value = $values|get:$g_idx:null
                    }
                  }
                }
                var.update $g_idx { value = $g_idx + 1 }
              }
            }

            // If found, increment frequency and update access time
            conditional {
              if ($found_idx >= 0) {
                var $new_values2 { value = [] }
                var $new_freqs2 { value = [] }
                var $new_times2 { value = [] }
                var $g2_idx { value = 0 }

                foreach ($values) {
                  each as $v {
                    conditional {
                      if ($g2_idx == $found_idx) {
                        var.update $new_values2 { value = $new_values2|merge:[$v] }
                        var $curr_freq { value = $frequencies|get:$found_idx:0 }
                        var.update $new_freqs2 { value = $new_freqs2|merge:[($curr_freq + 1)] }
                        var.update $new_times2 { value = $new_times2|merge:[$time_counter] }
                      }
                      else {
                        var.update $new_values2 { value = $new_values2|merge:[$v] }
                        var.update $new_freqs2 { value = $new_freqs2|merge:[$frequencies|get:$g2_idx:0] }
                        var.update $new_times2 { value = $new_times2|merge:[$access_times|get:$g2_idx:0] }
                      }
                    }
                    var.update $g2_idx { value = $g2_idx + 1 }
                  }
                }

                var.update $values { value = $new_values2 }
                var.update $frequencies { value = $new_freqs2 }
                var.update $access_times { value = $new_times2 }
              }
            }

            // Record result
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

    // Build final cache state
    var $final_state { value = [] }
    var $fs_idx { value = 0 }
    foreach ($keys) {
      each as $k {
        var $fs_item {
          value = {
            key: $k,
            value: $values|get:$fs_idx:0,
            frequency: $frequencies|get:$fs_idx:0
          }
        }
        var.update $final_state {
          value = $final_state|merge:[$fs_item]
        }
        var.update $fs_idx { value = $fs_idx + 1 }
      }
    }
  }

  response = {
    operations: $results,
    final_cache_state: $final_state
  }
}
