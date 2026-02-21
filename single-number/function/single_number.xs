// Single Number - Classic coding exercise using XOR bit manipulation
// Given a non-empty array where every element appears twice except for one,
// find that single one using the XOR property: a ^ a = 0 and a ^ 0 = a
function "single_number" {
  description = "Finds the element that appears only once in an array where all others appear twice"
  
  input {
    int[] nums { description = "Array of integers where every element appears twice except one" }
  }
  
  stack {
    // XOR all numbers together
    // Property 1: a ^ a = 0 (any number XOR itself is 0)
    // Property 2: a ^ 0 = a (any number XOR 0 is itself)
    // Property 3: XOR is commutative and associative (order doesn't matter)
    //
    // Example: [4, 1, 2, 1, 2]
    // 4 ^ 1 ^ 2 ^ 1 ^ 2
    // = 4 ^ (1 ^ 1) ^ (2 ^ 2)  [commutative property]
    // = 4 ^ 0 ^ 0               [property 1]
    // = 4                       [property 2]
    
    var $result { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        var $result {
          value = $result|bitwise_xor:$num
        }
      }
    }
  }
  
  response = $result
}
