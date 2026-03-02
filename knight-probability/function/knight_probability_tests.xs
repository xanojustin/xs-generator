function "knight_probability_tests" {
  description = "Run all test cases for knight probability"
  
  input {
  }
  
  stack {
    // Test case 1: 3x3 board, 2 moves, starting at (0, 0) - corner
    // Expected: 0.0625 (1/16)
    function.run "knight_probability" {
      input = {
        n: 3
        k: 2
        row: 0
        column: 0
      }
    } as $result1
    
    // Test case 2: 3x3 board, 1 move, starting at (1, 1) - center
    // Expected: 0.0 (all 8 moves go off board)
    function.run "knight_probability" {
      input = {
        n: 3
        k: 1
        row: 1
        column: 1
      }
    } as $result2
    
    // Test case 3: 1x1 board, 0 moves - edge case
    // Expected: 1.0 (no moves, stays in place)
    function.run "knight_probability" {
      input = {
        n: 1
        k: 0
        row: 0
        column: 0
      }
    } as $result3
    
    // Test case 4: 3x3 board, 1 move from corner
    // Expected: 0.25 (2 of 8 moves stay on board)
    function.run "knight_probability" {
      input = {
        n: 3
        k: 1
        row: 0
        column: 0
      }
    } as $result4
    
    // Return all results
    var $results { 
      value = {
        test_3x3_k2_corner: $result1
        test_3x3_k1_center: $result2
        test_1x1_k0: $result3
        test_3x3_k1_corner: $result4
      }
    }
  }
  
  response = $results
}
