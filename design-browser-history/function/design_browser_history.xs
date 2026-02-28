function "design_browser_history" {
  description = "Simulates browser history navigation with visit, back, and forward operations"
  input {
    text operation { description = "Operation to perform: 'visit', 'back', 'forward', or 'init'" }
    text[] history { description = "Array of URLs in history (required for all operations)" }
    int current_index { description = "Current position in history (required for all operations)" }
    text? url { description = "URL to visit (required for 'visit' and 'init' operations)" }
    int? steps { description = "Number of steps to go back/forward (required for 'back' and 'forward' operations)" }
  }
  stack {
    // Initialize the result object
    var $result {
      value = {
        history: $input.history,
        current_index: $input.current_index,
        current_url: ""
      }
    }

    // Handle different operations
    switch ($input.operation) {
      case ("init") {
        // Initialize browser history with homepage
        var $init_history { value = [$input.url] }
        var.update $result {
          value = {
            history: $init_history,
            current_index: 0,
            current_url: $input.url
          }
        }
      } break
      
      case ("visit") {
        // Visit a new URL - clears forward history
        // Get the current history up to current_index + 1
        var $new_history { value = [] }
        var $i { value = 0 }
        
        // Copy history from start to current_index inclusive
        while ($i <= $input.current_index && $i < ($input.history|count)) {
          each {
            var $url_at_index {
              value = $input.history[$i]
            }
            var.update $new_history {
              value = $new_history|merge:[$url_at_index]
            }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Add the new URL
        var.update $new_history {
          value = $new_history|merge:[$input.url]
        }
        
        // Update result with new history and new current index
        var $new_index { value = ($new_history|count) - 1 }
        var.update $result {
          value = {
            history: $new_history,
            current_index: $new_index,
            current_url: $input.url
          }
        }
      } break
      
      case ("back") {
        // Go back in history
        var $back_steps { value = $input.steps }
        
        // Ensure steps doesn't go below 0
        conditional {
          if ($back_steps > $input.current_index) {
            var.update $back_steps { value = $input.current_index }
          }
        }
        
        var $new_index { value = $input.current_index - $back_steps }
        var $current_url {
          value = $input.history[$new_index]
        }
        
        var.update $result {
          value = {
            history: $input.history,
            current_index: $new_index,
            current_url: $current_url
          }
        }
      } break
      
      case ("forward") {
        // Go forward in history
        var $forward_steps { value = $input.steps }
        var $max_forward {
          value = ($input.history|count) - $input.current_index - 1
        }
        
        // Ensure steps doesn't go beyond history length
        conditional {
          if ($forward_steps > $max_forward) {
            var.update $forward_steps { value = $max_forward }
          }
        }
        
        var $new_index { value = $input.current_index + $forward_steps }
        var $current_url {
          value = $input.history[$new_index]
        }
        
        var.update $result {
          value = {
            history: $input.history,
            current_index: $new_index,
            current_url: $current_url
          }
        }
      } break
      
      default {
        // Unknown operation - return current state
        var $current_url {
          value = $input.history[$input.current_index]
        }
        var.update $result {
          value = {
            history: $input.history,
            current_index: $input.current_index,
            current_url: $current_url
          }
        }
      }
    }
  }
  response = $result
}