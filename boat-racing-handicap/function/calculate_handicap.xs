function "calculate_handicap" {
  description = "Calculate corrected time for boat racing using PHRF handicap system"
  input {
    int phrf_rating filters=min:-500|max:300
    decimal course_distance filters=min:0
    int elapsed_time_seconds filters=min:0
  }
  stack {
    // Convert elapsed time to hours for calculation
    var $elapsed_hours {
      value = $input.elapsed_time_seconds / 3600.0
    }
    
    // PHRF Time-on-Time formula:
    // Corrected Time = Elapsed Time × (650 / (550 + PHRF Rating))
    // Where 650 is the standard time-on-time multiplier base
    var $time_on_time_multiplier {
      value = 650.0 / (550.0 + $input.phrf_rating)
    }
    
    // Calculate corrected time in hours
    var $corrected_time_hours {
      value = $elapsed_hours * $time_on_time_multiplier
    }
    
    // Convert back to seconds
    var $corrected_time_seconds {
      value = ($corrected_time_hours * 3600.0)|round
    }
    
    // Calculate time allowance (difference between elapsed and corrected)
    var $time_allowance_seconds {
      value = $corrected_time_seconds - $input.elapsed_time_seconds
    }
  }
  response = {
    phrf_rating: $input.phrf_rating,
    course_distance: $input.course_distance,
    elapsed_time_seconds: $input.elapsed_time_seconds,
    corrected_time_seconds: $corrected_time_seconds,
    time_allowance_seconds: $time_allowance_seconds,
    time_on_time_multiplier: $time_on_time_multiplier
  }
}