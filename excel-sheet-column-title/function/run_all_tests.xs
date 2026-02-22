function "run_all_tests" {
  input {
  }

  stack {
    // Test case 1: Basic case (1 -> A)
    function.run "convert_to_title" {
      input = { column_number: 1 }
    } as $result1
    debug.log { value = "Test 1: 1 -> " ~ $result1 }

    // Test case 2: Single letter Z (26 -> Z)
    function.run "convert_to_title" {
      input = { column_number: 26 }
    } as $result2
    debug.log { value = "Test 2: 26 -> " ~ $result2 }

    // Test case 3: Double letter AA (27 -> AA)
    function.run "convert_to_title" {
      input = { column_number: 27 }
    } as $result3
    debug.log { value = "Test 3: 27 -> " ~ $result3 }

    // Test case 4: AB (28 -> AB)
    function.run "convert_to_title" {
      input = { column_number: 28 }
    } as $result4
    debug.log { value = "Test 4: 28 -> " ~ $result4 }

    // Test case 5: AZ (52 -> AZ)
    function.run "convert_to_title" {
      input = { column_number: 52 }
    } as $result5
    debug.log { value = "Test 5: 52 -> " ~ $result5 }

    // Test case 6: BA (53 -> BA)
    function.run "convert_to_title" {
      input = { column_number: 53 }
    } as $result6
    debug.log { value = "Test 6: 53 -> " ~ $result6 }

    // Test case 7: ZZ (702 -> ZZ)
    function.run "convert_to_title" {
      input = { column_number: 702 }
    } as $result7
    debug.log { value = "Test 7: 702 -> " ~ $result7 }

    // Test case 8: AAA (703 -> AAA)
    function.run "convert_to_title" {
      input = { column_number: 703 }
    } as $result8
    debug.log { value = "Test 8: 703 -> " ~ $result8 }

    // Test case 9: Larger number (2147 -> CVC)
    function.run "convert_to_title" {
      input = { column_number: 2147 }
    } as $result9
    debug.log { value = "Test 9: 2147 -> " ~ $result9 }

    // Store results in variable for response
    var $test_results {
      value = {
        test_results: [
          { input: 1, expected: "A", actual: $result1 },
          { input: 26, expected: "Z", actual: $result2 },
          { input: 27, expected: "AA", actual: $result3 },
          { input: 28, expected: "AB", actual: $result4 },
          { input: 52, expected: "AZ", actual: $result5 },
          { input: 53, expected: "BA", actual: $result6 },
          { input: 702, expected: "ZZ", actual: $result7 },
          { input: 703, expected: "AAA", actual: $result8 },
          { input: 2147, expected: "CVC", actual: $result9 }
        ]
      }
    }
  }

  response = $test_results
}
