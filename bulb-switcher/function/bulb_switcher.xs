// Bulb Switcher - Mathematical problem
// There are n bulbs initially off. In round i, you flip every i-th bulb.
// Return the number of bulbs that remain on after n rounds.
// Key insight: Only perfect squares have an odd number of divisors,
// so only bulbs at perfect square positions remain on.
function "bulb_switcher" {
  description = "Returns the number of bulbs that remain on after n rounds of flipping"
  
  input {
    int n { description = "Number of bulbs and rounds (1 <= n <= 10^9)" }
  }
  
  stack {
    // Handle edge case: no bulbs
    conditional {
      if ($input.n <= 0) {
        return { value = 0 }
      }
    }
    
    // The number of bulbs that remain on equals the number of perfect squares <= n
    // This is because only perfect squares have an odd number of divisors
    // For example: bulb 9 is flipped in rounds 1, 3, 9 (3 times - odd) -> stays ON
    // Bulb 6 is flipped in rounds 1, 2, 3, 6 (4 times - even) -> stays OFF
    // The count of perfect squares <= n is floor(sqrt(n))
    
    var $sqrt_n { value = $input.n|sqrt|floor }
  }
  
  response = $sqrt_n
}
