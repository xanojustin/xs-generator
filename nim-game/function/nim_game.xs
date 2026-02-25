function "nim_game" {
  description = "Determine if the first player can win the Nim Game with n stones"
  
  input {
    int n { description = "Number of stones in the pile" }
  }
  
  stack {
    // Nim Game strategy: If n is divisible by 4, first player loses
    // Otherwise, first player can always win by playing optimally
    var $can_win { value = ($input.n % 4) != 0 }
  }
  
  response = $can_win
}
