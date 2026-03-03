function "run_tests" {
  description = "Run all test cases for range sum query"
  input {
  }
  stack {
    var $test_nums { value = [-2, 0, 3, -5, 2, -1] }
    var $results { value = [] }
    
    // Test Case 1: Basic case - sum of first 3 elements
    function.run "range_sum_query" {
      input = {
        nums: $test_nums
        left: 0
        right: 2
      }
    } as $result1
    array.push $results { value = { test: 1, nums: $test_nums, left: 0, right: 2, result: $result1, expected: 1 } }
    
    // Test Case 2: Middle range
    function.run "range_sum_query" {
      input = {
        nums: $test_nums
        left: 2
        right: 5
      }
    } as $result2
    array.push $results { value = { test: 2, nums: $test_nums, left: 2, right: 5, result: $result2, expected: -1 } }
    
    // Test Case 3: Full array
    function.run "range_sum_query" {
      input = {
        nums: $test_nums
        left: 0
        right: 5
      }
    } as $result3
    array.push $results { value = { test: 3, nums: $test_nums, left: 0, right: 5, result: $result3, expected: -3 } }
    
    // Test Case 4: Single element
    function.run "range_sum_query" {
      input = {
        nums: $test_nums
        left: 3
        right: 3
      }
    } as $result4
    array.push $results { value = { test: 4, nums: $test_nums, left: 3, right: 3, result: $result4, expected: -5 } }
    
    // Test Case 5: Single element array
    function.run "range_sum_query" {
      input = {
        nums: [5]
        left: 0
        right: 0
      }
    } as $result5
    array.push $results { value = { test: 5, nums: [5], left: 0, right: 0, result: $result5, expected: 5 } }
    
    // Test Case 6: Two elements
    function.run "range_sum_query" {
      input = {
        nums: [1, 2]
        left: 0
        right: 1
      }
    } as $result6
    array.push $results { value = { test: 6, nums: [1, 2], left: 0, right: 1, result: $result6, expected: 3 } }
  }
  response = $results
}
