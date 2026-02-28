function "reveal_cards" {
  description = "Find the ordering of a deck that reveals cards in increasing order"
  input {
    int[] deck { description = "Array of integers representing the deck of cards" }
  }
  stack {
    // Sort the deck in increasing order
    var $sorted_deck {
      value = $input.deck|sort:$$:"int":true
    }

    // Get the count of cards
    var $n {
      value = $sorted_deck|count
    }

    // Initialize result array
    var $result {
      value = []|fill:$n:0
    }

    // Initialize queue with indices 0 to n-1
    var $queue {
      value = (0..($n - 1))
    }

    // Process each card in sorted order (smallest to largest)
    foreach ($sorted_deck) {
      each as $card {
        // Get the front index from the queue
        var $idx {
          value = $queue|first
        }

        // Get queue count for calculations
        var $queue_count {
          value = $queue|count
        }

        // Remove the front element from the queue (slice from 1 to end)
        var $new_queue_count {
          value = $queue_count - 1
        }
        var $queue {
          value = $queue|slice:1:$new_queue_count
        }

        // Update queue_count after removal
        var $queue_count {
          value = $queue|count
        }

        // Place the card at the revealed position
        // Build result by merging slices: before idx, card, after idx
        var $before {
          value = $result|slice:0:$idx
        }
        var $after_start {
          value = $idx + 1
        }
        var $result_count {
          value = $result|count
        }
        var $after_length {
          value = $result_count - $idx - 1
        }
        var $after {
          value = $result|slice:$after_start:$after_length
        }
        var $result {
          value = $before|merge:[$card]|merge:$after
        }

        // If there are still cards in queue, move the next front to back
        conditional {
          if ($queue_count > 0) {
            var $next_front {
              value = $queue|first
            }
            var $queue_count2 {
              value = $queue|count
            }
            var $new_count {
              value = $queue_count2 - 1
            }
            var $queue {
              value = $queue|slice:1:$new_count|push:$next_front
            }
          }
        }
      }
    }
  }
  response = $result
}
