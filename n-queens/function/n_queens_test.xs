// N-Queens Test Suite
// Runs multiple test cases for the N-Queens solver
function "n_queens_test" {
  description = "Run all test cases for N-Queens"
  
  input {
  }
  
  stack {
    // Test Case 1: n = 1 (edge case - single queen)
    function.run "n_queens" {
      input = { n: 1 }
    } as $result1
    debug.log { value = "Test 1 - n=1, Expected: 1 solution, Got: " ~ ($result1|count|to_text) ~ " solutions" }
    
    // Test Case 2: n = 4 (classic case with 2 solutions)
    function.run "n_queens" {
      input = { n: 4 }
    } as $result2
    debug.log { value = "Test 2 - n=4, Expected: 2 solutions, Got: " ~ ($result2|count|to_text) ~ " solutions" }
    
    // Test Case 3: n = 0 (edge case - invalid input)
    function.run "n_queens" {
      input = { n: 0 }
    } as $result3
    debug.log { value = "Test 3 - n=0, Expected: 0 solutions, Got: " ~ ($result3|count|to_text) ~ " solutions" }
    
    // Test Case 4: n = 2 (no solution case)
    function.run "n_queens" {
      input = { n: 2 }
    } as $result4
    debug.log { value = "Test 4 - n=2, Expected: 0 solutions, Got: " ~ ($result4|count|to_text) ~ " solutions" }
    
    // Test Case 5: n = 3 (no solution case)
    function.run "n_queens" {
      input = { n: 3 }
    } as $result5
    debug.log { value = "Test 5 - n=3, Expected: 0 solutions, Got: " ~ ($result3|count|to_text) ~ " solutions" }
  }
  
  response = {
    test1_n1: $result1,
    test2_n4: $result2,
    test3_n0: $result3,
    test4_n2: $result4,
    test5_n3: $result5
  }
}
