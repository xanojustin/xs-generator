function "find_kth_bit_tests" {
  description = "Run all test cases for find_kth_bit function"
  
  input {
  }
  
  stack {
    // Test case 1: n=3, k=1 -> "0"
    // S3 = "0111001", position 1 is "0"
    function.run "find_kth_bit" {
      input = { n: 3, k: 1 }
    } as $result1
    debug.log { value = "Test 1: n=3, k=1 -> " ~ $result1 }
    
    // Test case 2: n=3, k=5 -> "1"
    // S3 = "0111001", position 5 is "1"
    function.run "find_kth_bit" {
      input = { n: 3, k: 5 }
    } as $result2
    debug.log { value = "Test 2: n=3, k=5 -> " ~ $result2 }
    
    // Test case 3: n=4, k=11 -> "1"
    function.run "find_kth_bit" {
      input = { n: 4, k: 11 }
    } as $result3
    debug.log { value = "Test 3: n=4, k=11 -> " ~ $result3 }
    
    // Test case 4: n=1, k=1 -> "0" (edge case: minimum values)
    function.run "find_kth_bit" {
      input = { n: 1, k: 1 }
    } as $result4
    debug.log { value = "Test 4: n=1, k=1 -> " ~ $result4 }
    
    // Test case 5: n=2, k=3 -> "1"
    // S2 = "011", position 3 is "1"
    function.run "find_kth_bit" {
      input = { n: 2, k: 3 }
    } as $result5
    debug.log { value = "Test 5: n=2, k=3 -> " ~ $result5 }
    
    // Return all results as an object
    var $results { 
      value = { 
        test1: { n: 3, k: 1, expected: "0", actual: $result1 },
        test2: { n: 3, k: 5, expected: "1", actual: $result2 },
        test3: { n: 4, k: 11, expected: "1", actual: $result3 },
        test4: { n: 1, k: 1, expected: "0", actual: $result4 },
        test5: { n: 2, k: 3, expected: "1", actual: $result5 }
      } 
    }
  }
  
  response = $results
}
