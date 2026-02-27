function "find_max_xor" {
  description = "Test function that calls maximum_xor with various test cases"
  
  input {
  }
  
  stack {
    // Test case 1: Classic example
    function.run "maximum_xor" {
      input = { nums: [3, 10, 5, 25, 2, 8] }
    } as $result1
    debug.log { value = "Test 1 - Input: [3, 10, 5, 25, 2, 8], Max XOR: " ~ ($result1|to_text) }
    
    // Test case 2: Single element (edge case)
    function.run "maximum_xor" {
      input = { nums: [0] }
    } as $result2
    debug.log { value = "Test 2 - Input: [0], Max XOR: " ~ ($result2|to_text) }
    
    // Test case 3: Two elements
    function.run "maximum_xor" {
      input = { nums: [2, 4] }
    } as $result3
    debug.log { value = "Test 3 - Input: [2, 4], Max XOR: " ~ ($result3|to_text) }
    
    // Test case 4: Small array
    function.run "maximum_xor" {
      input = { nums: [8, 1, 2] }
    } as $result4
    debug.log { value = "Test 4 - Input: [8, 1, 2], Max XOR: " ~ ($result4|to_text) }
    
    // Test case 5: Larger numbers
    function.run "maximum_xor" {
      input = { nums: [14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66, 70] }
    } as $result5
    debug.log { value = "Test 5 - Input: [14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66, 70], Max XOR: " ~ ($result5|to_text) }
    
    // Store final results
    var $all_results {
      value = {
        test1: { input: [3, 10, 5, 25, 2, 8], expected: 28, result: $result1 },
        test2: { input: [0], expected: 0, result: $result2 },
        test3: { input: [2, 4], expected: 6, result: $result3 },
        test4: { input: [8, 1, 2], expected: 10, result: $result4 },
        test5: { input: [14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66, 70], expected: 127, result: $result5 }
      }
    }
    
    // Return summary
    return { value = $all_results }
  }
  
  response = $all_results
}
