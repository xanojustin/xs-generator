function "fibonacci_tests" {
  description = "Test runner for fibonacci function - runs multiple test cases"
  
  input {
  }
  
  stack {
    // Test case 1: n = 0 (edge case - should return 0)
    function.run "fibonacci" {
      input = { n: 0 }
    } as $result_0
    
    // Test case 2: n = 1 (edge case - should return 1)
    function.run "fibonacci" {
      input = { n: 1 }
    } as $result_1
    
    // Test case 3: n = 5 (basic case - should return 5)
    function.run "fibonacci" {
      input = { n: 5 }
    } as $result_5
    
    // Test case 4: n = 10 (larger case - should return 55)
    function.run "fibonacci" {
      input = { n: 10 }
    } as $result_10
    
    // Test case 5: n = 20 (boundary case - should return 6765)
    function.run "fibonacci" {
      input = { n: 20 }
    } as $result_20
    
    // Compile all results
    var $test_results {
      value = {
        test_0: {
          input: 0,
          expected: 0,
          actual: $result_0,
          passed: (`$result_0 == 0`)
        },
        test_1: {
          input: 1,
          expected: 1,
          actual: $result_1,
          passed: (`$result_1 == 1`)
        },
        test_5: {
          input: 5,
          expected: 5,
          actual: $result_5,
          passed: (`$result_5 == 5`)
        },
        test_10: {
          input: 10,
          expected: 55,
          actual: $result_10,
          passed: (`$result_10 == 55`)
        },
        test_20: {
          input: 20,
          expected: 6765,
          actual: $result_20,
          passed: (`$result_20 == 6765`)
        }
      }
    }
    
    // Log results
    debug.log { value = "Fibonacci Test Results:" }
    debug.log { value = $test_results|json_encode }
  }
  
  response = $test_results
}
