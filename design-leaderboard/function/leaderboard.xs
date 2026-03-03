// Design a Leaderboard - System design exercise
// Implements a leaderboard with add_score, top(K), and reset operations
function "leaderboard" {
  description = "Design a Leaderboard with add_score, top(K), and reset operations"

  input {
    text operation { description = "Operation to perform: 'add_score', 'top', or 'reset'" }
    int player_id { description = "Player ID (required for add_score and reset)" }
    int score { description = "Score to add (required for add_score)" }
    int k { description = "Number of top players to sum (required for top operation)" }
    json initial_scores { description = "Initial player scores object (optional, for state persistence)" }
  }

  stack {
    // Initialize or restore player scores
    conditional {
      if ($input.initial_scores|has:"scores") {
        var $scores { value = $input.initial_scores.scores }
      }
      else {
        var $scores { value = {} }
      }
    }

    var $result { value = null }

    conditional {
      // Add score to a player
      if ($input.operation == "add_score") {
        conditional {
          if ($scores|has:($input.player_id|to_text)) {
            // Player exists, add to existing score
            var $current_score {
              value = $scores|get:($input.player_id|to_text)
            }
            var $new_score {
              value = $current_score + $input.score
            }
            var $scores {
              value = $scores|set:($input.player_id|to_text):$new_score
            }
          }
          else {
            // New player
            var $scores {
              value = $scores|set:($input.player_id|to_text):$input.score
            }
          }
        }
        var $result {
          value = {
            success: true,
            player_id: $input.player_id,
            operation: "add_score"
          }
        }
      }

      // Get sum of top K players' scores
      elseif ($input.operation == "top") {
        // Extract all scores into an array
        var $all_scores { value = [] }
        foreach ($scores) {
          each as $player_score {
            var $all_scores {
              value = $all_scores|merge:[$player_score]
            }
          }
        }

        // Sort scores in descending order
        var $sorted_scores { value = $all_scores|sort:"desc" }

        // Sum top K scores
        var $sum { value = 0 }
        var $sorted_count { value = $sorted_scores|count }
        var $count {
          value = ($sorted_count < $input.k) ? $sorted_count : $input.k
        }
        var $i { value = 0 }

        while ($i < $count) {
          each {
            var $score {
              value = $sorted_scores|index:$i
            }
            var $sum { value = $sum + $score }
            var $i { value = $i + 1 }
          }
        }

        var $result {
          value = {
            sum: $sum,
            k: $input.k,
            operation: "top"
          }
        }
      }

      // Reset a player's score to 0
      elseif ($input.operation == "reset") {
        var $scores {
          value = $scores|set:($input.player_id|to_text):0
        }
        var $result {
          value = {
            success: true,
            player_id: $input.player_id,
            operation: "reset"
          }
        }
      }
    }

    // Return both the result and updated scores for state persistence
    var $final_response {
      value = {
        result: $result,
        scores: $scores
      }
    }
  }

  response = $final_response
}
