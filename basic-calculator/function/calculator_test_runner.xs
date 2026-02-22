function "calculator_test_runner" {
  description = "Runs test cases for the calculator function"

  input {
  }

  stack {
    // Test case 1: Addition
    function.run "calculator" {
      input = {
        operation: "add",
        a: 10,
        b: 5
      }
    } as $result1
    debug.log { value = "10 + 5 = " ~ ($result1.result|to_text) }

    // Test case 2: Subtraction
    function.run "calculator" {
      input = {
        operation: "subtract",
        a: 10,
        b: 3
      }
    } as $result2
    debug.log { value = "10 - 3 = " ~ ($result2.result|to_text) }

    // Test case 3: Multiplication
    function.run "calculator" {
      input = {
        operation: "multiply",
        a: 7,
        b: 6
      }
    } as $result3
    debug.log { value = "7 * 6 = " ~ ($result3.result|to_text) }

    // Test case 4: Division
    function.run "calculator" {
      input = {
        operation: "divide",
        a: 20,
        b: 4
      }
    } as $result4
    debug.log { value = "20 / 4 = " ~ ($result4.result|to_text) }

    // Test case 5: Division by zero (edge case)
    function.run "calculator" {
      input = {
        operation: "divide",
        a: 10,
        b: 0
      }
    } as $result5
    debug.log { value = "10 / 0 error: " ~ ($result5.error|first_notnull:"none") }

    // Test case 6: Invalid operation
    function.run "calculator" {
      input = {
        operation: "power",
        a: 2,
        b: 3
      }
    } as $result6
    debug.log { value = "Invalid operation error: " ~ ($result6.error|first_notnull:"none") }

    // Test case 7: Negative numbers
    function.run "calculator" {
      input = {
        operation: "add",
        a: -5,
        b: 3
      }
    } as $result7
    debug.log { value = "-5 + 3 = " ~ ($result7.result|to_text) }

    // Final summary
    var $summary {
      value = {
        tests_run: 7,
        results: [
          { test: "10 + 5", result: $result1.result },
          { test: "10 - 3", result: $result2.result },
          { test: "7 * 6", result: $result3.result },
          { test: "20 / 4", result: $result4.result },
          { test: "10 / 0 (error)", error: $result5.error },
          { test: "invalid op (error)", error: $result6.error },
          { test: "-5 + 3", result: $result7.result }
        ]
      }
    }
  }

  response = $summary
}
