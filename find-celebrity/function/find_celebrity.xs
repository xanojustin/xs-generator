function "find_celebrity" {
  description = "Find the celebrity in a party of n people. A celebrity is known by everyone but knows no one."
  input {
    json knows_matrix {
      description = "Adjacency matrix where knows_matrix[i][j] = 1 if person i knows person j"
    }
    int n {
      description = "Number of people at the party"
    }
  }
  stack {
    // Validate n >= 1
    precondition ($input.n >= 1) {
      error_type = "inputerror"
      error = "Number of people must be at least 1"
    }

    // Edge case: only one person is a celebrity
    conditional {
      if ($input.n == 1) {
        return { value = 0 }
      }
    }

    // Step 1: Find the candidate using elimination
    // Start with person 0 as candidate
    var $candidate { value = 0 }

    // Iterate through all people
    for ($input.n - 1) {
      each as $i {
        // Check if candidate knows person i+1
        // If candidate knows someone, they can't be the celebrity
        // Access: matrix[candidate][i+1]
        var $candidate_knows {
          value = $input.knows_matrix[$candidate][$i + 1]
        }

        conditional {
          if ($candidate_knows == 1) {
            // Current candidate knows person i+1, so they can't be celebrity
            // Person i+1 might be the celebrity
            var.update $candidate { value = $i + 1 }
          }
        }
      }
    }

    // Step 2: Verify the candidate is actually a celebrity
    // - Everyone should know the candidate
    // - Candidate should know no one

    var $is_celebrity { value = true }
    var $person { value = 0 }

    // Check each person
    while ($person < $input.n) {
      each {
        conditional {
          if ($person != $candidate) {
            // Check if person knows candidate (should be 1)
            var $knows_candidate {
              value = $input.knows_matrix[$person][$candidate]
            }

            // Check if candidate knows person (should be 0)
            var $candidate_knows_person {
              value = $input.knows_matrix[$candidate][$person]
            }

            conditional {
              // If person doesn't know candidate OR candidate knows person
              // Then candidate is not a celebrity
              if ($knows_candidate != 1 || $candidate_knows_person != 0) {
                var.update $is_celebrity { value = false }
              }
            }
          }
        }

        var.update $person { value = $person + 1 }
      }
    }

    conditional {
      if ($is_celebrity == true) {
        return { value = $candidate }
      }
      else {
        return { value = -1 }
      }
    }
  }
  response = $candidate
}
