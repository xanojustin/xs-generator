function "run_tests" {
  description = "Run all test cases for max_consecutive_ones"
  input {
  }
  stack {
    // Test case 1: Basic case with consecutive 1s
    function.run "max_consecutive_ones" {
      input = {
        nums: [1, 1, 0, 1, 1, 1]
      }
    } as $result1

    debug.log {
      value = "Test 1 - Input: [1,1,0,1,1,1], Expected: 3, Got: " ~ ($result1|to_text)
    }

    // Test case 2: No consecutive 1s
    function.run "max_consecutive_ones" {
      input = {
        nums: [0, 0, 0, 0]
      }
    } as $result2

    debug.log {
      value = "Test 2 - Input: [0,0,0,0], Expected: 0, Got: " ~ ($result2|to_text)
    }

    // Test case 3: All 1s
    function.run "max_consecutive_ones" {
      input = {
        nums: [1, 1, 1, 1, 1]
      }
    } as $result3

    debug.log {
      value = "Test 3 - Input: [1,1,1,1,1], Expected: 5, Got: " ~ ($result3|to_text)
    }

    // Test case 4: Empty array
    function.run "max_consecutive_ones" {
      input = {
        nums: []
      }
    } as $result4

    debug.log {
      value = "Test 4 - Input: [], Expected: 0, Got: " ~ ($result4|to_text)
    }

    // Test case 5: Single element (1)
    function.run "max_consecutive_ones" {
      input = {
        nums: [1]
      }
    } as $result5

    debug.log {
      value = "Test 5 - Input: [1], Expected: 1, Got: " ~ ($result5|to_text)
    }

    // Test case 6: Single element (0)
    function.run "max_consecutive_ones" {
      input = {
        nums: [0]
      }
    } as $result6

    debug.log {
      value = "Test 6 - Input: [0], Expected: 0, Got: " ~ ($result6|to_text)
    }

    // Compile all results
    var $all_results {
      value = {
        test1: $result1,
        test2: $result2,
        test3: $result3,
        test4: $result4,
        test5: $result5,
        test6: $result6
      }
    }
  }
  response = $all_results
}
