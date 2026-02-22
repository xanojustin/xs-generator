function "search_insert_position_tests" {
  description = "Run all test cases for search_insert_position function"
  
  input {
  }
  
  stack {
    // Test case 1: Target found in middle
    function.run "search_insert_position" {
      input = {
        nums: [1, 3, 5, 6],
        target: 5
      }
    } as $result1
    debug.log { value = "Test 1 - Target 5 in [1,3,5,6]: index = " ~ ($result1|to_text) }
    
    // Test case 2: Target not found, insert in middle
    function.run "search_insert_position" {
      input = {
        nums: [1, 3, 5, 6],
        target: 2
      }
    } as $result2
    debug.log { value = "Test 2 - Target 2 in [1,3,5,6]: index = " ~ ($result2|to_text) }
    
    // Test case 3: Target greater than all elements
    function.run "search_insert_position" {
      input = {
        nums: [1, 3, 5, 6],
        target: 7
      }
    } as $result3
    debug.log { value = "Test 3 - Target 7 in [1,3,5,6]: index = " ~ ($result3|to_text) }
    
    // Test case 4: Empty array
    function.run "search_insert_position" {
      input = {
        nums: [],
        target: 5
      }
    } as $result4
    debug.log { value = "Test 4 - Target 5 in []: index = " ~ ($result4|to_text) }
    
    // Test case 5: Target less than all elements
    function.run "search_insert_position" {
      input = {
        nums: [1, 3, 5, 6],
        target: 0
      }
    } as $result5
    debug.log { value = "Test 5 - Target 0 in [1,3,5,6]: index = " ~ ($result5|to_text) }
    
    // Test case 6: Single element, target not found
    function.run "search_insert_position" {
      input = {
        nums: [1],
        target: 0
      }
    } as $result6
    debug.log { value = "Test 6 - Target 0 in [1]: index = " ~ ($result6|to_text) }
    
    // Compile all results
    var $all_results {
      value = {
        test1_target_5: $result1,
        test2_target_2: $result2,
        test3_target_7: $result3,
        test4_empty_array: $result4,
        test5_target_0: $result5,
        test6_single_element: $result6
      }
    }
  }
  
  response = $all_results
}
