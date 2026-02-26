function "test_strobogrammatic" {
  description = "Test function for strobogrammatic number checker"
  
  input {
  }
  
  stack {
    // Test case 1: 69 - should be true
    function.run "is_strobogrammatic" {
      input = { number: "69" }
    } as $result1
    debug.log { value = "Test 1 (69): " ~ ($result1|to_text) }
    
    // Test case 2: 88 - should be true
    function.run "is_strobogrammatic" {
      input = { number: "88" }
    } as $result2
    debug.log { value = "Test 2 (88): " ~ ($result2|to_text) }
    
    // Test case 3: 123 - should be false
    function.run "is_strobogrammatic" {
      input = { number: "123" }
    } as $result3
    debug.log { value = "Test 3 (123): " ~ ($result3|to_text) }
    
    // Test case 4: 818 - should be true
    function.run "is_strobogrammatic" {
      input = { number: "818" }
    } as $result4
    debug.log { value = "Test 4 (818): " ~ ($result4|to_text) }
    
    // Test case 5: Single digit 1 - should be true
    function.run "is_strobogrammatic" {
      input = { number: "1" }
    } as $result5
    debug.log { value = "Test 5 (1): " ~ ($result5|to_text) }
    
    // Test case 6: Single digit 2 - should be false
    function.run "is_strobogrammatic" {
      input = { number: "2" }
    } as $result6
    debug.log { value = "Test 6 (2): " ~ ($result6|to_text) }
    
    // Test case 7: 6969 - should be true
    function.run "is_strobogrammatic" {
      input = { number: "6969" }
    } as $result7
    debug.log { value = "Test 7 (6969): " ~ ($result7|to_text) }
    
    // Collect all results
    var $all_results {
      value = {
        "69": $result1,
        "88": $result2,
        "123": $result3,
        "818": $result4,
        "1": $result5,
        "2": $result6,
        "6969": $result7
      }
    }
  }
  
  response = $all_results
}
