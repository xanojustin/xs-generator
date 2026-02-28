// Online Stock Span - Calculate the stock span for each day
// The stock span for a given day is the maximum number of consecutive days
// just before the given day, for which the price is less than or equal to
// the price on the given day.
function "online_stock_span" {
  description = "Calculates stock span for each day's price using a monotonic stack"

  input {
    int[] prices { description = "Array of daily stock prices" }
  }

  stack {
    // Array to store span results for each day
    var $spans { value = [] }
    // Stack to store pairs of [price, span] - monotonic decreasing
    var $stack { value = [] }
    // Index for iterating through prices
    var $i { value = 0 }

    while ($i < ($input.prices|count)) {
      each {
        var $current_price { value = $input.prices[$i] }
        var $current_span { value = 1 }

        // Pop from stack while current price >= stack top price
        // and accumulate spans
        var $continue_popping { value = true }

        while ($continue_popping) {
          each {
            conditional {
              // Check if stack is not empty and current price >= top price
              if ((($stack|count) > 0) && ($current_price >= ($stack|last).price)) {
                // Pop the top and add its span to current span
                var $top_item { value = $stack|last }
                var $current_span { value = $current_span + $top_item.span }

                // Remove top from stack by creating new array without last
                var $new_stack { value = [] }
                var $j { value = 0 }
                while ($j < (($stack|count) - 1)) {
                  each {
                    var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                    var.update $j { value = $j + 1 }
                  }
                }
                var $stack { value = $new_stack }
              }
              else {
                // Either stack is empty or current price < top price
                var $continue_popping { value = false }
              }
            }
          }
        }

        // Push current [price, span] onto stack
        var $new_item {
          value = {
            price: $current_price,
            span: $current_span
          }
        }
        var $stack { value = $stack|merge:[$new_item] }

        // Add current span to results
        var $spans { value = $spans|merge:[$current_span] }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $spans
}
