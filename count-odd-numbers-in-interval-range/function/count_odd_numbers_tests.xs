function "count_odd_numbers_tests" {
  description = "Run multiple test cases for count_odd_numbers function"
  
  input {
  }
  
  stack {
    // Test case 1: Basic range with both odd (3, 5, 7 = 3 odds)
    function.run "count_odd_numbers" {
      input = { low: 3, high: 7 }
    } as $result1
    debug.log { value = "Test 1 (3-7): Expected 3, Got " ~ ($result1|to_text) }
    
    // Test case 2: Range with even bounds (3, 5, 7 = 3 odds)
    function.run "count_odd_numbers" {
      input = { low: 2, high: 8 }
    } as $result2
    debug.log { value = "Test 2 (2-8): Expected 3, Got " ~ ($result2|to_text) }
    
    // Test case 3: Single odd number
    function.run "count_odd_numbers" {
      input = { low: 5, high: 5 }
    } as $result3
    debug.log { value = "Test 3 (5-5): Expected 1, Got " ~ ($result3|to_text) }
    
    // Test case 4: Single even number
    function.run "count_odd_numbers" {
      input = { low: 4, high: 4 }
    } as $result4
    debug.log { value = "Test 4 (4-4): Expected 0, Got " ~ ($result4|to_text) }
    
    // Test case 5: Large range (1-100 has 50 odds)
    function.run "count_odd_numbers" {
      input = { low: 1, high: 100 }
    } as $result5
    debug.log { value = "Test 5 (1-100): Expected 50, Got " ~ ($result5|to_text) }
    
    // Test case 6: Zero included (1, 3, 5 = 3 odds)
    function.run "count_odd_numbers" {
      input = { low: 0, high: 5 }
    } as $result6
    debug.log { value = "Test 6 (0-5): Expected 3, Got " ~ ($result6|to_text) }
    
    // Collect all results
    var $all_results {
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
  
  response = $all_results
}