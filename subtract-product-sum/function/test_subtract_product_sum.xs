function "test_subtract_product_sum" {
  description = "Test function that runs multiple test cases for subtract_product_sum"
  
  input {
  }
  
  stack {
    // Test case 1: Basic case - n = 234
    // Product: 2*3*4 = 24, Sum: 2+3+4 = 9, Result: 24-9 = 15
    function.run "subtract_product_sum" {
      input = { n: 234 }
    } as $result1
    debug.log { value = "Test 1 (n=234): Expected 15, Got: " ~ ($result1|to_text) }
    
    // Test case 2: Single digit - n = 5
    // Product: 5, Sum: 5, Result: 5-5 = 0
    function.run "subtract_product_sum" {
      input = { n: 5 }
    } as $result2
    debug.log { value = "Test 2 (n=5): Expected 0, Got: " ~ ($result2|to_text) }
    
    // Test case 3: Contains zero - n = 101
    // Product: 1*0*1 = 0, Sum: 1+0+1 = 2, Result: 0-2 = -2
    function.run "subtract_product_sum" {
      input = { n: 101 }
    } as $result3
    debug.log { value = "Test 3 (n=101): Expected -2, Got: " ~ ($result3|to_text) }
    
    // Test case 4: Large number - n = 9999
    // Product: 9*9*9*9 = 6561, Sum: 9+9+9+9 = 36, Result: 6561-36 = 6525
    function.run "subtract_product_sum" {
      input = { n: 9999 }
    } as $result4
    debug.log { value = "Test 4 (n=9999): Expected 6525, Got: " ~ ($result4|to_text) }
    
    // Test case 5: Two digits - n = 42
    // Product: 4*2 = 8, Sum: 4+2 = 6, Result: 8-6 = 2
    function.run "subtract_product_sum" {
      input = { n: 42 }
    } as $result5
    debug.log { value = "Test 5 (n=42): Expected 2, Got: " ~ ($result5|to_text) }
    
    // Compile all results into an object for the response
    var $all_results {
      value = {
        test1: { input: 234, expected: 15, actual: $result1 },
        test2: { input: 5, expected: 0, actual: $result2 },
        test3: { input: 101, expected: -2, actual: $result3 },
        test4: { input: 9999, expected: 6525, actual: $result4 },
        test5: { input: 42, expected: 2, actual: $result5 }
      }
    }
  }
  
  response = $all_results
}
