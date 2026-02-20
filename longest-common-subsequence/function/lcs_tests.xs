function "lcs_tests" {
  description = "Test runner for Longest Common Subsequence function - runs multiple test cases"
  
  input {
  }
  
  stack {
    // Test case 1: Both strings empty (edge case - should return 0)
    function.run "lcs" {
      input = { str1: "", str2: "" }
    } as $result_empty
    
    // Test case 2: First string empty (edge case - should return 0)
    function.run "lcs" {
      input = { str1: "", str2: "abc" }
    } as $result_empty1
    
    // Test case 3: Basic case - "abcde" and "ace" (should return 3 - "ace")
    function.run "lcs" {
      input = { str1: "abcde", str2: "ace" }
    } as $result_basic1
    
    // Test case 4: Basic case - "abc" and "abc" (should return 3 - identical strings)
    function.run "lcs" {
      input = { str1: "abc", str2: "abc" }
    } as $result_basic2
    
    // Test case 5: No common subsequence - "abc" and "def" (should return 0)
    function.run "lcs" {
      input = { str1: "abc", str2: "def" }
    } as $result_nocommon
    
    // Test case 6: Longer strings - "XMJYAUZ" and "MZJAWXU" (should return 4 - "MJAU")
    function.run "lcs" {
      input = { str1: "XMJYAUZ", str2: "MZJAWXU" }
    } as $result_longer
    
    // Test case 7: Substring at end - "abcdef" and "def" (should return 3)
    function.run "lcs" {
      input = { str1: "abcdef", str2: "def" }
    } as $result_suffix
    
    // Compile all results
    var $test_results {
      value = {
        test_empty_both: {
          str1: "",
          str2: "",
          expected: 0,
          actual: $result_empty,
          passed: (`$result_empty == 0`)
        },
        test_empty_one: {
          str1: "",
          str2: "abc",
          expected: 0,
          actual: $result_empty1,
          passed: (`$result_empty1 == 0`)
        },
        test_basic_ace: {
          str1: "abcde",
          str2: "ace",
          expected: 3,
          actual: $result_basic1,
          passed: (`$result_basic1 == 3`)
        },
        test_identical: {
          str1: "abc",
          str2: "abc",
          expected: 3,
          actual: $result_basic2,
          passed: (`$result_basic2 == 3`)
        },
        test_no_common: {
          str1: "abc",
          str2: "def",
          expected: 0,
          actual: $result_nocommon,
          passed: (`$result_nocommon == 0`)
        },
        test_longer: {
          str1: "XMJYAUZ",
          str2: "MZJAWXU",
          expected: 4,
          actual: $result_longer,
          passed: (`$result_longer == 4`)
        },
        test_suffix: {
          str1: "abcdef",
          str2: "def",
          expected: 3,
          actual: $result_suffix,
          passed: (`$result_suffix == 3`)
        }
      }
    }
    
    // Log results
    debug.log { value = "Longest Common Subsequence Test Results:" }
    debug.log { value = $test_results|json_encode }
  }
  
  response = $test_results
}
