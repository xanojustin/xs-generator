run.job {
  description = "Run candy distribution algorithm with test cases"
  
  main {
    // Test case 1: Basic case with peak in middle
    function.run "candy" {
      input = { ratings: [1, 0, 2] }
    } as $result1
    
    // Test case 2: Equal ratings
    function.run "candy" {
      input = { ratings: [1, 2, 2] }
    } as $result2
    
    // Test case 3: Single child (edge case)
    function.run "candy" {
      input = { ratings: [5] }
    } as $result3
    
    // Test case 4: All same ratings
    function.run "candy" {
      input = { ratings: [3, 3, 3, 3] }
    } as $result4
    
    // Test case 5: Strictly increasing
    function.run "candy" {
      input = { ratings: [1, 2, 3, 4, 5] }
    } as $result5
    
    // Test case 6: Strictly decreasing
    function.run "candy" {
      input = { ratings: [5, 4, 3, 2, 1] }
    } as $result6
    
    // Test case 7: Empty array (edge case)
    function.run "candy" {
      input = { ratings: [] }
    } as $result7
    
    // Log all results
    debug.log { value = "Test 1 (ratings: [1,0,2]): Expected 5, Got " ~ ($result1|to_text) }
    debug.log { value = "Test 2 (ratings: [1,2,2]): Expected 4, Got " ~ ($result2|to_text) }
    debug.log { value = "Test 3 (ratings: [5]): Expected 1, Got " ~ ($result3|to_text) }
    debug.log { value = "Test 4 (ratings: [3,3,3,3]): Expected 4, Got " ~ ($result4|to_text) }
    debug.log { value = "Test 5 (ratings: [1,2,3,4,5]): Expected 15, Got " ~ ($result5|to_text) }
    debug.log { value = "Test 6 (ratings: [5,4,3,2,1]): Expected 15, Got " ~ ($result6|to_text) }
    debug.log { value = "Test 7 (ratings: []): Expected 0, Got " ~ ($result7|to_text) }
    
    return { value = {
      test1: $result1,
      test2: $result2,
      test3: $result3,
      test4: $result4,
      test5: $result5,
      test6: $result6,
      test7: $result7
    }}
  }
}
