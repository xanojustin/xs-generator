function "run_tests" {
  description = "Run test cases for shortest unsorted continuous subarray"
  input {
  }
  stack {
    // Test Case 1: Basic case [2,6,4,8,10,9,15]
    function.run "shortest_unsorted_subarray" {
      input = { nums: [2, 6, 4, 8, 10, 9, 15] }
    } as $result1
    debug.log { value = "Test 1: [2,6,4,8,10,9,15] -> Expected: 5, Got: " ~ ($result1|to_text) }
    
    // Test Case 2: Already sorted [1,2,3,4]
    function.run "shortest_unsorted_subarray" {
      input = { nums: [1, 2, 3, 4] }
    } as $result2
    debug.log { value = "Test 2: [1,2,3,4] -> Expected: 0, Got: " ~ ($result2|to_text) }
    
    // Test Case 3: Single element
    function.run "shortest_unsorted_subarray" {
      input = { nums: [1] }
    } as $result3
    debug.log { value = "Test 3: [1] -> Expected: 0, Got: " ~ ($result3|to_text) }
    
    // Test Case 4: Reverse sorted [3,2,1]
    function.run "shortest_unsorted_subarray" {
      input = { nums: [3, 2, 1] }
    } as $result4
    debug.log { value = "Test 4: [3,2,1] -> Expected: 3, Got: " ~ ($result4|to_text) }
    
    // Test Case 5: Two elements out of place [1,3,2,4,5]
    function.run "shortest_unsorted_subarray" {
      input = { nums: [1, 3, 2, 4, 5] }
    } as $result5
    debug.log { value = "Test 5: [1,3,2,4,5] -> Expected: 2, Got: " ~ ($result5|to_text) }
    
    // Test Case 6: Empty array
    function.run "shortest_unsorted_subarray" {
      input = { nums: [] }
    } as $result6
    debug.log { value = "Test 6: [] -> Expected: 0, Got: " ~ ($result6|to_text) }
    
    var $summary {
      value = {
        test1: { input: [2, 6, 4, 8, 10, 9, 15], expected: 5, got: $result1 },
        test2: { input: [1, 2, 3, 4], expected: 0, got: $result2 },
        test3: { input: [1], expected: 0, got: $result3 },
        test4: { input: [3, 2, 1], expected: 3, got: $result4 },
        test5: { input: [1, 3, 2, 4, 5], expected: 2, got: $result5 },
        test6: { input: [], expected: 0, got: $result6 }
      }
    }
  }
  response = $summary
}
