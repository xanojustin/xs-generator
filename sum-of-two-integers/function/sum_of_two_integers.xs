// Sum of Two Integers - Bit manipulation exercise
// Adds two integers without using + or - operators
// Uses bitwise XOR for sum and AND+multiply for carry
function "sum_of_two_integers" {
  description = "Adds two integers using bitwise operations without + or - operators"
  
  input {
    int a { description = "First integer" }
    int b { description = "Second integer" }
  }
  
  stack {
    var $x { value = $input.a }
    var $y { value = $input.b }
    
    // Loop until there's no carry
    while ($y != 0) {
      each {
        // Calculate carry: positions where both bits are 1
        // Using bitwise_and filter
        var $carry { 
          value = $x|bitwise_and:$y
        }
        
        // Sum without carry: XOR gives us the sum bits
        var $new_x { 
          value = $x|bitwise_xor:$y
        }
        
        // Multiply carry by 2 (equivalent to left shift by 1)
        var $new_y { 
          value = $carry * 2
        }
        
        // Update values for next iteration
        var.update $x { value = $new_x }
        var.update $y { value = $new_y }
      }
    }
  }
  
  response = $x
}
