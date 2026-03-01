// Design Hit Counter - System Design Exercise
// Design a hit counter which counts the number of hits received in the past 5 minutes (300 seconds)
// Supports: hit(timestamp) to record hits and getHits(timestamp) to query counts
function "hit_counter" {
  description = "Records hits and returns hit counts within a 5-minute window"
  
  input {
    json test_operations { description = "Array of operations with action and timestamp" }
  }
  
  stack {
    // Constants
    var $WINDOW_SIZE { value = 300 }
    var $results { value = [] }
    
    // Clear any existing hits from previous runs
    db.query hits {
      return = { type: "list" }
    } as $existing_hits
    
    foreach ($existing_hits) {
      each as $hit {
        db.del hits {
          field_name = "id"
          field_value = $hit.id
        }
      }
    }
    
    // Process each test operation
    foreach ($input.test_operations) {
      each as $op {
        conditional {
          // Record a hit
          if ($op.action == "hit") {
            db.add hits {
              data = { timestamp: $op.timestamp }
            } as $new_hit
            
            var $result { 
              value = { 
                action: "hit", 
                timestamp: $op.timestamp, 
                status: "recorded" 
              } 
            }
          }
          // Get hits count within the past 5 minutes
          elseif ($op.action == "getHits") {
            var $start_time { value = $op.timestamp - $WINDOW_SIZE }
            
            db.query hits {
              where = $db.hits.timestamp > $start_time && $db.hits.timestamp <= $op.timestamp
              return = { type: "list" }
            } as $hits_in_window
            
            var $count { value = $hits_in_window|count }
            
            var $result { 
              value = { 
                action: "getHits", 
                timestamp: $op.timestamp, 
                window_start: $start_time,
                count: $count 
              } 
            }
          }
        }
        
        var $results { value = $results|merge:[$result] }
      }
    }
  }
  
  response = $results
}
