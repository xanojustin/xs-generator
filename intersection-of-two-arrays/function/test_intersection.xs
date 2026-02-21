function "test_intersection" {
  description = "Test runner for intersection function with multiple test cases"

  input {
  }

  stack {
    // Test Case 1: Basic intersection with common elements
    debug.log { value = "Test 1: Basic intersection" }
    function.run "intersection" {
      input = { array1: [1, 2, 2, 1], array2: [2, 2] }
    } as $result1
    debug.log { value = "Input: [1, 2, 2, 1] and [2, 2]" }
    debug.log { value = "Result: " ~ ($result1|json_encode) }
    debug.log { value = "Expected: [2]" }

    // Test Case 2: Multiple common elements
    debug.log { value = "" }
    debug.log { value = "Test 2: Multiple common elements" }
    function.run "intersection" {
      input = { array1: [4, 9, 5], array2: [9, 4, 9, 8, 4] }
    } as $result2
    debug.log { value = "Input: [4, 9, 5] and [9, 4, 9, 8, 4]" }
    debug.log { value = "Result: " ~ ($result2|json_encode) }
    debug.log { value = "Expected: [4, 9] (or [9, 4])" }

    // Test Case 3: No common elements
    debug.log { value = "" }
    debug.log { value = "Test 3: No common elements" }
    function.run "intersection" {
      input = { array1: [1, 2, 3], array2: [4, 5, 6] }
    } as $result3
    debug.log { value = "Input: [1, 2, 3] and [4, 5, 6]" }
    debug.log { value = "Result: " ~ ($result3|json_encode) }
    debug.log { value = "Expected: []" }

    // Test Case 4: Empty array (edge case)
    debug.log { value = "" }
    debug.log { value = "Test 4: Empty array" }
    function.run "intersection" {
      input = { array1: [], array2: [1, 2, 3] }
    } as $result4
    debug.log { value = "Input: [] and [1, 2, 3]" }
    debug.log { value = "Result: " ~ ($result4|json_encode) }
    debug.log { value = "Expected: []" }

    // Test Case 5: Single element match
    debug.log { value = "" }
    debug.log { value = "Test 5: Single element match" }
    function.run "intersection" {
      input = { array1: [7], array2: [7] }
    } as $result5
    debug.log { value = "Input: [7] and [7]" }
    debug.log { value = "Result: " ~ ($result5|json_encode) }
    debug.log { value = "Expected: [7]" }

    // Test Case 6: Duplicates handling
    debug.log { value = "" }
    debug.log { value = "Test 6: Duplicates handling" }
    function.run "intersection" {
      input = { array1: [1, 1, 1, 1], array2: [1, 1, 1] }
    } as $result6
    debug.log { value = "Input: [1, 1, 1, 1] and [1, 1, 1]" }
    debug.log { value = "Result: " ~ ($result6|json_encode) }
    debug.log { value = "Expected: [1]" }

    // Final summary
    debug.log { value = "" }
    debug.log { value = "=== All tests completed ===" }

    var $summary {
      value = {
        test1: $result1,
        test2: $result2,
        test3: $result3,
        test4: $result4,
        test5: $result5,
        test6: $result6
      }
    }
  }

  response = $summary
}
