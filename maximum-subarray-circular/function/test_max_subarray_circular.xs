function "test_max_subarray_circular" {
  description = "Test function that runs multiple test cases for max_subarray_circular"
  input {
  }
  stack {
    // Test Case 1: Basic circular wrap case
    // Input: [5, -3, 5] -> Expected: 10 (5 + 5, wrapping around the -3)
    function.run "max_subarray_circular" {
      input = { nums: [5, -3, 5] }
    } as $result1
    debug.log { value = "Test 1 - [5, -3, 5]: " ~ ($result1|json_encode) }

    // Test Case 2: No wrap needed
    // Input: [1, -2, 3, -2] -> Expected: 3 (just the single element 3)
    function.run "max_subarray_circular" {
      input = { nums: [1, -2, 3, -2] }
    } as $result2
    debug.log { value = "Test 2 - [1, -2, 3, -2]: " ~ ($result2|json_encode) }

    // Test Case 3: Mixed values
    // Input: [3, -2, 2, -3] -> Expected: 3
    function.run "max_subarray_circular" {
      input = { nums: [3, -2, 2, -3] }
    } as $result3
    debug.log { value = "Test 3 - [3, -2, 2, -3]: " ~ ($result3|json_encode) }

    // Test Case 4: All negative numbers (edge case)
    // Input: [-2, -3, -1] -> Expected: -1 (the largest single element)
    function.run "max_subarray_circular" {
      input = { nums: [-2, -3, -1] }
    } as $result4
    debug.log { value = "Test 4 - [-2, -3, -1]: " ~ ($result4|json_encode) }

    // Test Case 5: Single element
    // Input: [5] -> Expected: 5
    function.run "max_subarray_circular" {
      input = { nums: [5] }
    } as $result5
    debug.log { value = "Test 5 - [5]: " ~ ($result5|json_encode) }

    // Test Case 6: Clear circular benefit
    // Input: [8, -1, 3, 4] -> Expected: 15 (8 + 3 + 4 = 15, skipping -1)
    function.run "max_subarray_circular" {
      input = { nums: [8, -1, 3, 4] }
    } as $result6
    debug.log { value = "Test 6 - [8, -1, 3, 4]: " ~ ($result6|json_encode) }

    // Test Case 7: Two elements
    // Input: [1, 2] -> Expected: 3 (1 + 2)
    function.run "max_subarray_circular" {
      input = { nums: [1, 2] }
    } as $result7
    debug.log { value = "Test 7 - [1, 2]: " ~ ($result7|json_encode) }

    // Test Case 8: Large positive wrap
    // Input: [5, -2, 3, 4, -5] -> Expected: 12 (3 + 4 + 5 = 12)
    function.run "max_subarray_circular" {
      input = { nums: [5, -2, 3, 4, -5] }
    } as $result8
    debug.log { value = "Test 8 - [5, -2, 3, 4, -5]: " ~ ($result8|json_encode) }

    // Compile results
    var $results {
      value = {
        test1: { input: [5, -3, 5], expected: 10, result: $result1 },
        test2: { input: [1, -2, 3, -2], expected: 3, result: $result2 },
        test3: { input: [3, -2, 2, -3], expected: 3, result: $result3 },
        test4: { input: [-2, -3, -1], expected: -1, result: $result4 },
        test5: { input: [5], expected: 5, result: $result5 },
        test6: { input: [8, -1, 3, 4], expected: 15, result: $result6 },
        test7: { input: [1, 2], expected: 3, result: $result7 },
        test8: { input: [5, -2, 3, 4, -5], expected: 12, result: $result8 }
      }
    }

    debug.log { value = "All test results: " ~ ($results|json_encode) }
  }
  response = $results
}
