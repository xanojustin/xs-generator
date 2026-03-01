function "subarray_product_less_than_k_tests" {
  description = "Test cases for subarray product less than k"

  input {
  }

  stack {
    // Test Case 1: Basic case - expected output: 8
    debug.log { value = "Test 1: nums=[10,5,2,6], k=100" }
    function.run "subarray_product_less_than_k" {
      input = { nums: [10,5,2,6], k: 100 }
    } as $result1
    debug.log { value = "Result: " ~ ($result1|to_text) ~ " (Expected: 8)" }

    // Test Case 2: k = 0 - expected output: 0
    debug.log { value = "Test 2: nums=[1,2,3], k=0" }
    function.run "subarray_product_less_than_k" {
      input = { nums: [1,2,3], k: 0 }
    } as $result2
    debug.log { value = "Result: " ~ ($result2|to_text) ~ " (Expected: 0)" }

    // Test Case 3: Empty array - expected output: 0
    debug.log { value = "Test 3: nums=[], k=100" }
    function.run "subarray_product_less_than_k" {
      input = { nums: [], k: 100 }
    } as $result3
    debug.log { value = "Result: " ~ ($result3|to_text) ~ " (Expected: 0)" }

    // Test Case 4: Single element valid - expected output: 1
    debug.log { value = "Test 4: nums=[5], k=10" }
    function.run "subarray_product_less_than_k" {
      input = { nums: [5], k: 10 }
    } as $result4
    debug.log { value = "Result: " ~ ($result4|to_text) ~ " (Expected: 1)" }

    // Test Case 5: Single element invalid - expected output: 0
    debug.log { value = "Test 5: nums=[5], k=5" }
    function.run "subarray_product_less_than_k" {
      input = { nums: [5], k: 5 }
    } as $result5
    debug.log { value = "Result: " ~ ($result5|to_text) ~ " (Expected: 0)" }

    // Summary
    debug.log { value = "=== All tests completed ===" }
  }

  response = { success: true }
}
