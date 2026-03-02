function "test_expressive_words" {
  description = "Test wrapper that runs multiple test cases for expressive_words"
  input {
  }
  stack {
    var $results { value = [] }
    
    // Test Case 1: Basic example from problem
    debug.log { value = "Test 1: Target='heeellooo', words=['hello', 'hi', 'heello']" }
    function.run "expressive_words" {
      input = {
        target: "heeellooo",
        words: ["hello", "hi", "heello"]
      }
    } as $result1
    debug.log { value = "Result: " ~ ($result1|to_text) }
    debug.log { value = "Expected: 1" }
    var $pass1 { value = $result1 == 1 }
    var $r1 { value = { test: 1, result: $result1, expected: 1, pass: $pass1 } }
    var.update $results { value = $results|merge:[$r1] }
    
    // Test Case 2: Empty words array
    debug.log { value = "\nTest 2: Target='hello', words=[]" }
    function.run "expressive_words" {
      input = {
        target: "hello",
        words: []
      }
    } as $result2
    debug.log { value = "Result: " ~ ($result2|to_text) }
    debug.log { value = "Expected: 0" }
    var $pass2 { value = $result2 == 0 }
    var $r2 { value = { test: 2, result: $result2, expected: 0, pass: $pass2 } }
    var.update $results { value = $results|merge:[$r2] }
    
    // Test Case 3: Multiple stretchy words
    debug.log { value = "\nTest 3: Target='zzzz', words=['zz', 'zzz', 'zzzz']" }
    function.run "expressive_words" {
      input = {
        target: "zzzz",
        words: ["zz", "zzz", "zzzz"]
      }
    } as $result3
    debug.log { value = "Result: " ~ ($result3|to_text) }
    debug.log { value = "Expected: 3" }
    var $pass3 { value = $result3 == 3 }
    var $r3 { value = { test: 3, result: $result3, expected: 3, pass: $pass3 } }
    var.update $results { value = $results|merge:[$r3] }
    
    // Test Case 4: Single character target
    debug.log { value = "\nTest 4: Target='aaaaa', words=['a', 'aa', 'aaa', 'aaaa', 'aaaaa']" }
    function.run "expressive_words" {
      input = {
        target: "aaaaa",
        words: ["a", "aa", "aaa", "aaaa", "aaaaa"]
      }
    } as $result4
    debug.log { value = "Result: " ~ ($result4|to_text) }
    debug.log { value = "Expected: 5" }
    var $pass4 { value = $result4 == 5 }
    var $r4 { value = { test: 4, result: $result4, expected: 5, pass: $pass4 } }
    var.update $results { value = $results|merge:[$r4] }
    
    // Summary
    debug.log { value = "\n=== Test Summary ===" }
    var $total_tests { value = ($results|count) }
    var $passed_tests { value = 0 }
    foreach ($results) {
      each as $r {
        conditional {
          if ($r|get:"pass" == true) {
            var.update $passed_tests { value = $passed_tests + 1 }
          }
        }
      }
    }
    debug.log { value = "Passed: " ~ ($passed_tests|to_text) ~ "/" ~ ($total_tests|to_text) }
  }
  response = $results
}
