function "calculate_clock_angle" {
  description = "Calculate the smaller angle between hour and minute hands of a clock"
  input {
    int hour { description = "Hour value (1-12)" }
    int minutes { description = "Minutes value (0-59)" }
  }
  stack {
    // Calculate hour hand position in degrees
    // Hour hand moves 30 degrees per hour + 0.5 degrees per minute
    var $hour_angle {
      value = ($input.hour|multiply:30) ~ ""
    }
    var $hour_minute_adjustment {
      value = ($input.minutes|multiply:0.5) ~ ""
    }
    var $hour_hand_position {
      value = ($hour_angle|to_decimal) + ($hour_minute_adjustment|to_decimal)
    }

    // Calculate minute hand position in degrees
    // Minute hand moves 6 degrees per minute
    var $minute_hand_position {
      value = $input.minutes|multiply:6
    }

    // Calculate absolute difference
    var $diff {
      value = $hour_hand_position - $minute_hand_position
    }
    conditional {
      if ($diff < 0) {
        var $diff {
          value = $diff|multiply:-1
        }
      }
    }

    // Return the smaller angle (diff or 360 - diff)
    var $complement {
      value = 360 - $diff
    }
    conditional {
      if ($diff <= $complement) {
        var $result {
          value = $diff
        }
      }
      else {
        var $result {
          value = $complement
        }
      }
    }
  }
  response = $result
}
