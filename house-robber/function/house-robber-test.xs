function "house-robber-test" {
  description = "Run all test cases for house robber"
  
  input {
  }
  
  stack {
    // Test Case 1: Basic case
    function.run "house-robber" {
      input = { nums: [1, 2, 3, 1] }
    } as $result1
    debug.log { value = "Test 1 - Input: [1, 2, 3, 1], Expected: 4, Got: " ~ ($result1|to_text) }
    
    // Test Case 2: Larger case
    function.run "house-robber" {
      input = { nums: [2, 7, 9, 3, 1] }
    } as $result2
    debug.log { value = "Test 2 - Input: [2, 7, 9, 3, 1], Expected: 12, Got: " ~ ($result2|to_text) }
    
    // Test Case 3: Empty array (edge case)
    function.run "house-robber" {
      input = { nums: [] }
    } as $result3
    debug.log { value = "Test 3 - Input: [], Expected: 0, Got: " ~ ($result3|to_text) }
    
    // Test Case 4: Single element (edge case)
    function.run "house-robber" {
      input = { nums: [5] }
    } as $result4
    debug.log { value = "Test 4 - Input: [5], Expected: 5, Got: " ~ ($result4|to_text) }
    
    // Test Case 5: All same values
    function.run "house-robber" {
      input = { nums: [5, 5, 5, 5, 5] }
    } as $result5
    debug.log { value = "Test 5 - Input: [5, 5, 5, 5, 5], Expected: 15, Got: " ~ ($result5|to_text) }
  }
  
  response = {
    test1: $result1,
    test2: $result2,
    test3: $result3,
    test4: $result4,
    test5: $result5
  }
}
