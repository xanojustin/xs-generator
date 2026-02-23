function "run_tests" {
  description = "Run test cases for integer to English conversion"
  input {
  }
  stack {
    // Test Case 1: Zero (edge case)
    function.run "integer_to_english" {
      input = { num: 0 }
    } as $result1
    debug.log { value = "Test 1 (0): " ~ $result1 }
    
    // Test Case 2: Single digit
    function.run "integer_to_english" {
      input = { num: 5 }
    } as $result2
    debug.log { value = "Test 2 (5): " ~ $result2 }
    
    // Test Case 3: Teen number
    function.run "integer_to_english" {
      input = { num: 15 }
    } as $result3
    debug.log { value = "Test 3 (15): " ~ $result3 }
    
    // Test Case 4: Round ten
    function.run "integer_to_english" {
      input = { num: 30 }
    } as $result4
    debug.log { value = "Test 4 (30): " ~ $result4 }
    
    // Test Case 5: Two digit with ones
    function.run "integer_to_english" {
      input = { num: 42 }
    } as $result5
    debug.log { value = "Test 5 (42): " ~ $result5 }
    
    // Test Case 6: One hundred (exact)
    function.run "integer_to_english" {
      input = { num: 100 }
    } as $result6
    debug.log { value = "Test 6 (100): " ~ $result6 }
    
    // Test Case 7: Three digit number
    function.run "integer_to_english" {
      input = { num: 123 }
    } as $result7
    debug.log { value = "Test 7 (123): " ~ $result7 }
    
    // Test Case 8: One thousand
    function.run "integer_to_english" {
      input = { num: 1000 }
    } as $result8
    debug.log { value = "Test 8 (1000): " ~ $result8 }
    
    // Test Case 9: Complex number with thousands
    function.run "integer_to_english" {
      input = { num: 12345 }
    } as $result9
    debug.log { value = "Test 9 (12345): " ~ $result9 }
    
    // Test Case 10: One million
    function.run "integer_to_english" {
      input = { num: 1000000 }
    } as $result10
    debug.log { value = "Test 10 (1000000): " ~ $result10 }
    
    // Test Case 11: Large complex number
    function.run "integer_to_english" {
      input = { num: 1234567 }
    } as $result11
    debug.log { value = "Test 11 (1234567): " ~ $result11 }
    
    // Collect all results
    var $all_results {
      value = {
        test1_zero: $result1,
        test2_single_digit: $result2,
        test3_teen: $result3,
        test4_round_ten: $result4,
        test5_two_digit: $result5,
        test6_hundred_exact: $result6,
        test7_three_digit: $result7,
        test8_thousand_exact: $result8,
        test9_thousands: $result9,
        test10_million_exact: $result10,
        test11_large_complex: $result11
      }
    }
  }
  response = $all_results
}
