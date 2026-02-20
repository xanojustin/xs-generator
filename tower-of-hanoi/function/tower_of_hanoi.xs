// Tower of Hanoi - Classic recursive problem
// Moves n disks from source peg to destination peg using auxiliary peg
// Returns array of moves to solve the puzzle
function "tower_of_hanoi" {
  description = "Solves Tower of Hanoi puzzle and returns sequence of moves"
  
  input {
    int num_disks filters=min:1 { description = "Number of disks to move (must be >= 1)" }
  }
  
  stack {
    // Call recursive helper to solve the puzzle
    function.run "tower_of_hanoi_helper" {
      input = { 
        n: $input.num_disks,
        source: "A",
        auxiliary: "B",
        destination: "C"
      }
    } as $moves
  }
  
  response = $moves
}
