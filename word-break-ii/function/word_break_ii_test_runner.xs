function "word_break_ii_test_runner" {
  description = "Test runner that executes all test cases for word_break_ii and returns comprehensive results"

  input {
  }

  stack {
    // Test Case 1: Basic case from LeetCode example
    debug.log { value = "=== Test Case 1: catsanddog ===" }
    function.run "word_break_ii" {
      input = {
        s: "catsanddog",
        wordDict: ["cat", "cats", "and", "sand", "dog"]
      }
    } as $result1
    debug.log { value = "Input: s='catsanddog', wordDict=['cat','cats','and','sand','dog']" }
    debug.log { value = "Result: " ~ ($result1|json_encode) }

    // Test Case 2: Multiple valid combinations
    debug.log { value = "=== Test Case 2: pineapplepenapple ===" }
    function.run "word_break_ii" {
      input = {
        s: "pineapplepenapple",
        wordDict: ["apple", "pen", "applepen", "pine", "pineapple"]
      }
    } as $result2
    debug.log { value = "Input: s='pineapplepenapple', wordDict=['apple','pen','applepen','pine','pineapple']" }
    debug.log { value = "Result: " ~ ($result2|json_encode) }

    // Test Case 3: No valid break (edge case)
    debug.log { value = "=== Test Case 3: catsandog (no valid break) ===" }
    function.run "word_break_ii" {
      input = {
        s: "catsandog",
        wordDict: ["cats", "dog", "sand", "and", "cat"]
      }
    } as $result3
    debug.log { value = "Input: s='catsandog', wordDict=['cats','dog','sand','and','cat']" }
    debug.log { value = "Result: " ~ ($result3|json_encode) }

    // Test Case 4: Single word match (edge case)
    debug.log { value = "=== Test Case 4: Single word match ===" }
    function.run "word_break_ii" {
      input = {
        s: "leetcode",
        wordDict: ["leetcode"]
      }
    } as $result4
    debug.log { value = "Input: s='leetcode', wordDict=['leetcode']" }
    debug.log { value = "Result: " ~ ($result4|json_encode) }

    // Test Case 5: Empty result for non-matching (edge case)
    debug.log { value = "=== Test Case 5: No dictionary match ===" }
    function.run "word_break_ii" {
      input = {
        s: "hello",
        wordDict: ["world", "test"]
      }
    } as $result5
    debug.log { value = "Input: s='hello', wordDict=['world','test']" }
    debug.log { value = "Result: " ~ ($result5|json_encode) }

    // Return summary
    debug.log { value = "=== All Tests Complete ===" }

    var $summary {
      value = {
        test1_catsanddog: $result1,
        test2_pineapple: $result2,
        test3_catsandog: $result3,
        test4_single: $result4,
        test5_no_match: $result5
      }
    }
  }

  response = $summary
}
