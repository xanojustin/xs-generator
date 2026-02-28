function "run_tests" {
  description = "Run test cases for max product of three"
  input {
  }
  stack {
    // Test Case 1: Basic case with all positive numbers
    function.run "max_product_of_three" {
      input = { nums: [1, 2, 3] }
    } as $result1
    debug.log { value = "Test 1 (basic positive): " ~ $result1 }

    // Test Case 2: Mixed positive and negative - two negatives make positive
    function.run "max_product_of_three" {
      input = { nums: [-10, -10, 1, 3, 2] }
    } as $result2
    debug.log { value = "Test 2 (two negatives): " ~ $result2 }

    // Test Case 3: All negative numbers
    function.run "max_product_of_three" {
      input = { nums: [-1, -2, -3, -4] }
    } as $result3
    debug.log { value = "Test 3 (all negative): " ~ $result3 }

    // Test Case 4: Contains zero
    function.run "max_product_of_three" {
      input = { nums: [-1, -2, 0, 5, 10] }
    } as $result4
    debug.log { value = "Test 4 (with zero): " ~ $result4 }

    // Test Case 5: Large numbers
    function.run "max_product_of_three" {
      input = { nums: [1000, 1000, 1000] }
    } as $result5
    debug.log { value = "Test 5 (large numbers): " ~ $result5 }

    // Return summary
    var $summary {
      value = {
        test1_basic_positive: $result1,
        test2_two_negatives: $result2,
        test3_all_negative: $result3,
        test4_with_zero: $result4,
        test5_large_numbers: $result5
      }
    }
  }
  response = $summary
}
