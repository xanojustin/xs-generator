function "should_print_message" {
  description = "Logger Rate Limiter - determines if a message should be printed based on 10-second cooldown"
  input {
    text message
    int timestamp
    object message_history? {
      schema {
        // Map of message text to last printed timestamp
        // e.g., { "hello": 1, "world": 5 }
      }
    }
  }
  stack {
    // Initialize message history if not provided
    var $history { value = $input.message_history ?? {} }
    var $message { value = $input.message }
    var $current_time { value = $input.timestamp }
    
    // Get the last printed time for this message (null if never printed)
    var $last_printed {
      value = $history|get:$message:0
    }
    
    // Determine if we should print:
    // - If never printed (last_printed is 0), print it
    // - If 10+ seconds since last print, print it
    // - Otherwise, don't print
    var $should_print {
      value = ($last_printed == 0) || ($current_time - $last_printed >= 10)
    }
    
    var $updated_history { value = $history }
    
    // If printing, update the history
    conditional {
      if ($should_print == true) {
        var.update $updated_history {
          value = $history|set:$message:$current_time
        }
      }
    }
  }
  response = {
    should_print: $should_print,
    updated_history: $updated_history
  }
}
