// Design a Stack With Increment Operation
// Implements a stack that supports push, pop, and increment operations
// increment(k, val): increments the bottom k elements by val
function "design_stack_increment" {
  description = "Stack with push, pop, and increment operations"
  
  input {
    text[] operations { description = "Array of operation names" }
    json values { description = "Array of parameter arrays for each operation" }
  }
  
  stack {
    var $stack { value = [] }
    var $results { value = [] }
    var $i { value = 0 }
    
    while ($i < $input.operations|count) {
      each {
        var $op { value = $input.operations[$i] }
        var $args { value = $input.values[$i] }
        
        switch ($op) {
          case ("push") {
            var $val { value = $args[0] }
            var $stack { value = $stack|merge:[$val] }
            var $results { value = $results|merge:[null] }
          } break
          case ("pop") {
            conditional {
              if (($stack|count) == 0) {
                var $results { value = $results|merge:[-1] }
              }
              else {
                var $top_idx { value = ($stack|count) - 1 }
                var $top_val { value = $stack[$top_idx] }
                var $new_stack { value = $stack|slice:0:$top_idx }
                var $stack { value = $new_stack }
                var $results { value = $results|merge:[$top_val] }
              }
            }
          } break
          case ("increment") {
            var $k { value = $args[0] }
            var $val { value = $args[1] }
            var $j { value = 0 }
            var $limit { value = $k }
            conditional {
              if ($limit > $stack|count) {
                var $limit { value = $stack|count }
              }
            }
            while ($j < $limit) {
              each {
                var $new_val { value = $stack[$j] + $val }
                var $stack { value = $stack|set:$j:$new_val }
                var.update $j { value = $j + 1 }
              }
            }
            var $results { value = $results|merge:[null] }
          } break
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $results
}
