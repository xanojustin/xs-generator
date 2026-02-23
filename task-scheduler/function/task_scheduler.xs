function "task_scheduler" {
  description = "Calculate the least number of time units to finish all tasks with cooldown period"
  input {
    text[] tasks
    int n filters=min:0
  }
  stack {
    // Handle edge case: no tasks
    precondition (($input.tasks|count) > 0) {
      error_type = "inputerror"
      error = "Tasks array cannot be empty"
    }
    
    // Count frequency of each task using object with set filter
    // Since XanoScript doesn't support dynamic object keys in var declarations,
    // we use the set filter which returns a new object with the property set
    var $frequency_map {
      value = {}
    }
    
    foreach ($input.tasks) {
      each as $task {
        // Get current count using get filter (returns null if key doesn't exist)
        var $current_count {
          value = $frequency_map|get:$task
        }
        
        conditional {
          if ($current_count == null) {
            // First occurrence of this task
            var $frequency_map {
              value = $frequency_map|set:$task:1
            }
          }
          else {
            // Increment existing count
            var $new_count {
              value = $current_count + 1
            }
            var $frequency_map {
              value = $frequency_map|set:$task:$new_count
            }
          }
        }
      }
    }
    
    // Find the maximum frequency and count how many tasks have that frequency
    var $max_freq {
      value = 0
    }
    var $max_freq_count {
      value = 0
    }
    
    // Iterate over object keys - since XanoScript doesn't have object.keys(),
    // we'll iterate over the tasks array again and use the frequency_map
    // But we need unique tasks only, so we'll track what we've seen
    var $seen_tasks {
      value = []
    }
    
    foreach ($input.tasks) {
      each as $task {
        // Check if we've already processed this task type
        var $already_seen {
          value = false
        }
        foreach ($seen_tasks) {
          each as $seen {
            conditional {
              if ($seen == $task) {
                var $already_seen {
                  value = true
                }
              }
            }
          }
        }
        
        conditional {
          if (!$already_seen) {
            // Mark as seen
            var $seen_tasks {
              value = $seen_tasks|push:$task
            }
            
            // Get frequency for this task
            var $count {
              value = $frequency_map|get:$task
            }
            
            conditional {
              if ($count > $max_freq) {
                var $max_freq {
                  value = $count
                }
                var $max_freq_count {
                  value = 1
                }
              }
              elseif ($count == $max_freq) {
                math.add $max_freq_count {
                  value = 1
                }
              }
            }
          }
        }
      }
    }
    
    // Calculate minimum time using the greedy formula
    // Formula: max(tasks.count, (max_freq - 1) * (n + 1) + max_freq_count)
    // This accounts for: number of chunks * chunk size + tasks with max frequency
    var $part_count {
      value = $max_freq - 1
    }
    var $part_length {
      value = $input.n + 1
    }
    var $empty_slots {
      value = $part_count * $part_length
    }
    var $min_time_formula {
      value = $empty_slots + $max_freq_count
    }
    
    // The result is the maximum of formula result and total number of tasks
    // (formula might underestimate when n is small)
    var $total_tasks {
      value = ($input.tasks|count)
    }
    
    var $result {
      value = $min_time_formula
    }
    conditional {
      if ($total_tasks > $min_time_formula) {
        var $result {
          value = $total_tasks
        }
      }
    }
  }
  response = $result
}
