function "test_runner" {
  description = "Run all test cases for sum of odd length subarrays"
  
  input {
  }
  
  stack {
    // Test Case 1: Standard example [1,4,2,5,3] -> 58
    function.run "sum_odd_length_subarrays" {
      input = { arr: [1, 4, 2, 5, 3] }
    } as $result1
    
    debug.log { value = "Test 1: Input [1,4,2,5,3], Expected 58, Got: " ~ ($result1|to_text) }
    
    // Test Case 2: Two elements [1,2] -> 3
    function.run "sum_odd_length_subarrays" {
      input = { arr: [1, 2] }
    } as $result2
    
    debug.log { value = "Test 2: Input [1,2], Expected 3, Got: " ~ ($result2|to_text) }
    
    // Test Case 3: Three elements [10,11,12] -> 66
    function.run "sum_odd_length_subarrays" {
      input = { arr: [10, 11, 12] }
    } as $result3
    
    debug.log { value = "Test 3: Input [10,11,12], Expected 66, Got: " ~ ($result3|to_text) }
    
    // Test Case 4: Single element [5] -> 5
    function.run "sum_odd_length_subarrays" {
      input = { arr: [5] }
    } as $result4
    
    debug.log { value = "Test 4: Input [5], Expected 5, Got: " ~ ($result4|to_text) }
    
    // Test Case 5: Seven elements [1,2,3,4,5,6,7] -> 112
    function.run "sum_odd_length_subarrays" {
      input = { arr: [1, 2, 3, 4, 5, 6, 7] }
    } as $result5
    
    debug.log { value = "Test 5: Input [1,2,3,4,5,6,7], Expected 112, Got: " ~ ($result5|to_text) }
    
    // Summary
    debug.log { value = "All tests completed!" }
    
    var $all_results {
      value = {
        test1: $result1,
        test2: $result2,
        test3: $result3,
        test4: $result4,
        test5: $result5
      }
    }
  }
  
  response = $all_results
}
