function "run_all_tests" {
  input {
  }

  stack {
    // Test case 1: Basic case (A -> 1)
    function.run "convert_to_number" {
      input = { column_title: "A" }
    } as $result1
    debug.log { value = "Test 1: A -> " ~ ($result1|to_text) }

    // Test case 2: Single letter B (B -> 2)
    function.run "convert_to_number" {
      input = { column_title: "B" }
    } as $result2
    debug.log { value = "Test 2: B -> " ~ ($result2|to_text) }

    // Test case 3: Single letter Z (Z -> 26)
    function.run "convert_to_number" {
      input = { column_title: "Z" }
    } as $result3
    debug.log { value = "Test 3: Z -> " ~ ($result3|to_text) }

    // Test case 4: Double letter AA (AA -> 27)
    function.run "convert_to_number" {
      input = { column_title: "AA" }
    } as $result4
    debug.log { value = "Test 4: AA -> " ~ ($result4|to_text) }

    // Test case 5: AB (AB -> 28)
    function.run "convert_to_number" {
      input = { column_title: "AB" }
    } as $result5
    debug.log { value = "Test 5: AB -> " ~ ($result5|to_text) }

    // Test case 6: AZ (AZ -> 52)
    function.run "convert_to_number" {
      input = { column_title: "AZ" }
    } as $result6
    debug.log { value = "Test 6: AZ -> " ~ ($result6|to_text) }

    // Test case 7: BA (BA -> 53)
    function.run "convert_to_number" {
      input = { column_title: "BA" }
    } as $result7
    debug.log { value = "Test 7: BA -> " ~ ($result7|to_text) }

    // Test case 8: ZY (ZY -> 701)
    function.run "convert_to_number" {
      input = { column_title: "ZY" }
    } as $result8
    debug.log { value = "Test 8: ZY -> " ~ ($result8|to_text) }

    // Test case 9: ZZ (ZZ -> 702)
    function.run "convert_to_number" {
      input = { column_title: "ZZ" }
    } as $result9
    debug.log { value = "Test 9: ZZ -> " ~ ($result9|to_text) }

    // Test case 10: AAA (AAA -> 703)
    function.run "convert_to_number" {
      input = { column_title: "AAA" }
    } as $result10
    debug.log { value = "Test 10: AAA -> " ~ ($result10|to_text) }

    // Test case 11: Larger input (CVC -> 2147)
    function.run "convert_to_number" {
      input = { column_title: "CVC" }
    } as $result11
    debug.log { value = "Test 11: CVC -> " ~ ($result11|to_text) }

    // Test case 12: lowercase input (aa -> 27, should handle case)
    function.run "convert_to_number" {
      input = { column_title: "aa" }
    } as $result12
    debug.log { value = "Test 12: aa -> " ~ ($result12|to_text) }

    // Store results in variable for response
    var $test_results {
      value = {
        test_results: [
          { input: "A", expected: 1, actual: $result1 },
          { input: "B", expected: 2, actual: $result2 },
          { input: "Z", expected: 26, actual: $result3 },
          { input: "AA", expected: 27, actual: $result4 },
          { input: "AB", expected: 28, actual: $result5 },
          { input: "AZ", expected: 52, actual: $result6 },
          { input: "BA", expected: 53, actual: $result7 },
          { input: "ZY", expected: 701, actual: $result8 },
          { input: "ZZ", expected: 702, actual: $result9 },
          { input: "AAA", expected: 703, actual: $result10 },
          { input: "CVC", expected: 2147, actual: $result11 },
          { input: "aa", expected: 27, actual: $result12 }
        ]
      }
    }
  }

  response = $test_results
}
