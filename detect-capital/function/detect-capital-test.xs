function "detect-capital-test" {
  description = "Test the detect-capital function with various inputs"
  input {
  }
  stack {
    // Test case 1: All capitals (valid)
    function.run "detect-capital" {
      input = { word: "USA" }
    } as $result1
    debug.log { value = "Test 1 - USA: " ~ ($result1|to_text) }
    
    // Test case 2: All lowercase (valid)
    function.run "detect-capital" {
      input = { word: "leetcode" }
    } as $result2
    debug.log { value = "Test 2 - leetcode: " ~ ($result2|to_text) }
    
    // Test case 3: First capital only (valid)
    function.run "detect-capital" {
      input = { word: "Google" }
    } as $result3
    debug.log { value = "Test 3 - Google: " ~ ($result3|to_text) }
    
    // Test case 4: Invalid capital usage
    function.run "detect-capital" {
      input = { word: "FlaG" }
    } as $result4
    debug.log { value = "Test 4 - FlaG: " ~ ($result4|to_text) }
    
    // Test case 5: Another invalid case
    function.run "detect-capital" {
      input = { word: "gOOGLE" }
    } as $result5
    debug.log { value = "Test 5 - gOOGLE: " ~ ($result5|to_text) }
    
    // Test case 6: Single character (valid - all three rules apply)
    function.run "detect-capital" {
      input = { word: "A" }
    } as $result6
    debug.log { value = "Test 6 - A: " ~ ($result6|to_text) }
    
    // Test case 7: Single lowercase (valid)
    function.run "detect-capital" {
      input = { word: "m" }
    } as $result7
    debug.log { value = "Test 7 - m: " ~ ($result7|to_text) }
    
    // Collect all results
    var $test_results {
      value = {
        test1_USA: $result1,
        test2_leetcode: $result2,
        test3_Google: $result3,
        test4_FlaG: $result4,
        test5_gOOGLE: $result5,
        test6_A: $result6,
        test7_m: $result7
      }
    }
  }
  response = $test_results
}
