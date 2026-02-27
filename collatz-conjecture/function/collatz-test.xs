function "collatz-test" {
  description = "Run test cases for collatz-conjecture function"
  
  input {
  }
  
  stack {
    // Test case 1: n = 1 (edge case - already at 1, 0 steps)
    function.run "collatz-conjecture" {
      input = { n: 1 }
    } as $result1
    debug.log { value = "Test 1 (n=1): " ~ ($result1|to_text) ~ " steps (expected: 0)" }
    
    // Test case 2: n = 2 (even, divide by 2 -> 1, 1 step)
    function.run "collatz-conjecture" {
      input = { n: 2 }
    } as $result2
    debug.log { value = "Test 2 (n=2): " ~ ($result2|to_text) ~ " steps (expected: 1)" }
    
    // Test case 3: n = 3 (classic sequence: 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1, 7 steps)
    function.run "collatz-conjecture" {
      input = { n: 3 }
    } as $result3
    debug.log { value = "Test 3 (n=3): " ~ ($result3|to_text) ~ " steps (expected: 7)" }
    
    // Test case 4: n = 6 (6 -> 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1, 8 steps)
    function.run "collatz-conjecture" {
      input = { n: 6 }
    } as $result4
    debug.log { value = "Test 4 (n=6): " ~ ($result4|to_text) ~ " steps (expected: 8)" }
    
    // Test case 5: n = 7 (7 -> 22 -> 11 -> 34 -> 17 -> 52 -> 26 -> 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1, 16 steps)
    function.run "collatz-conjecture" {
      input = { n: 7 }
    } as $result5
    debug.log { value = "Test 5 (n=7): " ~ ($result5|to_text) ~ " steps (expected: 16)" }
    
    // Test case 6: n = 19 (longer sequence, 20 steps)
    function.run "collatz-conjecture" {
      input = { n: 19 }
    } as $result6
    debug.log { value = "Test 6 (n=19): " ~ ($result6|to_text) ~ " steps (expected: 20)" }
    
    // Return all results as an object
    var $all_results { 
      value = {
        test1_n1: $result1,
        test2_n2: $result2,
        test3_n3: $result3,
        test4_n6: $result4,
        test5_n7: $result5,
        test6_n19: $result6
      }
    }
  }
  
  response = $all_results
}
