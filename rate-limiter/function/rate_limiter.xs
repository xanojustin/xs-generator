// Rate Limiter - Classic system design interview problem
// Implements a sliding window rate limiter that controls request rate per user
// Returns true if request is allowed, false if rate limited
function "rate_limiter" {
  description = "Sliding window rate limiter - allows max 'limit' requests per 'window' seconds per user"
  
  input {
    object[] requests { 
      description = "Array of request objects with timestamp and user_id"
      schema {
        int timestamp { description = "Timestamp of the request" }
        text user_id { description = "User identifier" }
      }
    }
    int limit { description = "Maximum number of requests allowed in the time window" }
    int window { description = "Time window in seconds" }
  }
  
  stack {
    // Result array tracking which requests are allowed
    var $results { value = [] }
    
    // Map to track request timestamps per user (simulating in-memory storage)
    var $user_requests { value = {} }
    
    // Process each request
    var $i { value = 0 }
    while ($i < ($input.requests|count)) {
      each {
        var $request { value = $input.requests[$i] }
        var $user_id { value = $request.user_id }
        var $timestamp { value = $request.timestamp }
        
        // Get current user's request history
        var $history { value = $user_requests|get:$user_id|first_notnull:[] }
        
        // Calculate window start (current timestamp - window + 1)
        var $window_start { value = $timestamp - $input.window + 1 }
        
        // Filter to only requests within the current window
        var $recent_requests { value = [] }
        var $j { value = 0 }
        while ($j < ($history|count)) {
          each {
            conditional {
              if ($history[$j] >= $window_start) {
                var $recent_requests { value = $recent_requests|merge:[$history[$j]] }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Check if request is allowed
        conditional {
          if (($recent_requests|count) < $input.limit) {
            // Allow the request
            var $results { value = $results|merge:[true] }
            
            // Add timestamp to history
            var $recent_requests { value = $recent_requests|merge:[$timestamp] }
            var $user_requests { value = $user_requests|set:$user_id:$recent_requests }
          }
          else {
            // Rate limit the request
            var $results { value = $results|merge:[false] }
            
            // Still update the history (the sliding window moves)
            var $user_requests { value = $user_requests|set:$user_id:$recent_requests }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $results
}
