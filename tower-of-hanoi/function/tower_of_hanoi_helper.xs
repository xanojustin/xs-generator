// Recursive helper for Tower of Hanoi
// Returns array of moves to move n disks from source to destination
function "tower_of_hanoi_helper" {
  description = "Recursive helper for Tower of Hanoi algorithm"
  
  input {
    int n { description = "Number of disks to move" }
    text source { description = "Source peg name" }
    text auxiliary { description = "Auxiliary peg name" }
    text destination { description = "Destination peg name" }
  }
  
  stack {
    // Base case: no disks to move
    conditional {
      if (`$input.n == 0`) {
        var $result { value = [] }
      }
      elseif (`$input.n == 1`) {
        // Single disk: move directly from source to destination
        var $result { 
          value = [{ from: $input.source, to: $input.destination, disk: 1 }]
        }
      }
      else {
        // Recursive case:
        // 1. Move n-1 disks from source to auxiliary
        function.run "tower_of_hanoi_helper" {
          input = {
            n: $input.n - 1,
            source: $input.source,
            auxiliary: $input.destination,
            destination: $input.auxiliary
          }
        } as $moves_1
        
        // 2. Move the nth disk from source to destination
        var $move_n {
          value = [{ from: $input.source, to: $input.destination, disk: $input.n }]
        }
        
        // 3. Move n-1 disks from auxiliary to destination
        function.run "tower_of_hanoi_helper" {
          input = {
            n: $input.n - 1,
            source: $input.auxiliary,
            auxiliary: $input.source,
            destination: $input.destination
          }
        } as $moves_2
        
        // Combine all moves
        var $result {
          value = $moves_1 ~ $move_n ~ $moves_2
        }
      }
    }
  }
  
  response = $result
}
