function "time_needed_to_inform" {
  description = "Calculate the time needed to inform all employees through the company hierarchy"
  
  input {
    int n
    int headID
    int[] manager
    int[] informTime
  }
  
  stack {
    // Build adjacency list - subordinates for each manager
    var $subordinates { value = [] }
    for ($input.n) {
      each as $i {
        var $subordinates { value = $subordinates|push:[] }
      }
    }
    
    // Populate subordinates list
    for ($input.n) {
      each as $i {
        conditional {
          if ($input.manager[$i] != -1) {
            // Get current subordinates list for this manager
            var $mgr { value = $input.manager[$i] }
            var $current_list { value = $subordinates[$mgr] }
            var $updated_list { value = $current_list|push:$i }
            var $subordinates { value = $subordinates|set:$mgr:$updated_list }
          }
        }
      }
    }
    
    // BFS/DFS to calculate max time - use stack for DFS
    var $max_time { value = 0 }
    var $stack { value = [{ employee: $input.headID, time: 0 }] }
    
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $current { value = $stack|last }
        var $stack { value = $stack|slice:0:-1 }
        
        var $emp { value = $current|get:"employee" }
        var $curr_time { value = $current|get:"time" }
        
        // Update max time
        conditional {
          if ($curr_time > $max_time) {
            var $max_time { value = $curr_time }
          }
        }
        
        // Add subordinates to stack
        var $emp_subs { value = $subordinates[$emp] }
        var $inform_duration { value = $input.informTime[$emp] }
        
        foreach ($emp_subs) {
          each as $sub {
            var $new_entry { value = { employee: $sub, time: $curr_time + $inform_duration } }
            var $stack { value = $stack|push:$new_entry }
          }
        }
      }
    }
  }
  
  response = $max_time
}
