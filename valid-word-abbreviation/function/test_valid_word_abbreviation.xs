function "test_valid_word_abbreviation" {
  input {}
  
  stack {
    // Test case 1: Basic valid abbreviation (happy path)
    function.run "valid_word_abbreviation" {
      input = {
        word: "internationalization",
        abbr: "i12iz4n"
      }
    } as $result1
    debug.log { value = "Test 1 - word: 'internationalization', abbr: 'i12iz4n'" }
    debug.log { value = "Result: " ~ ($result1|to_text) }
    debug.log { value = "Expected: true" }
    
    // Test case 2: Invalid abbreviation (letters don't match)
    function.run "valid_word_abbreviation" {
      input = {
        word: "apple",
        abbr: "a2e"
      }
    } as $result2
    debug.log { value = "Test 2 - word: 'apple', abbr: 'a2e'" }
    debug.log { value = "Result: " ~ ($result2|to_text) }
    debug.log { value = "Expected: false" }
    
    // Test case 3: Abbreviation with number at start (edge case)
    function.run "valid_word_abbreviation" {
      input = {
        word: "hi",
        abbr: "2i"
      }
    } as $result3
    debug.log { value = "Test 3 - word: 'hi', abbr: '2i'" }
    debug.log { value = "Result: " ~ ($result3|to_text) }
    debug.log { value = "Expected: true" }
    
    // Test case 4: Leading zero not allowed (edge case)
    function.run "valid_word_abbreviation" {
      input = {
        word: "a",
        abbr: "01"
      }
    } as $result4
    debug.log { value = "Test 4 - word: 'a', abbr: '01'" }
    debug.log { value = "Result: " ~ ($result4|to_text) }
    debug.log { value = "Expected: false" }
    
    // Test case 5: Empty abbreviation should match empty word (boundary)
    function.run "valid_word_abbreviation" {
      input = {
        word: "",
        abbr: ""
      }
    } as $result5
    debug.log { value = "Test 5 - word: '', abbr: ''" }
    debug.log { value = "Result: " ~ ($result5|to_text) }
    debug.log { value = "Expected: true" }
    
    // Test case 6: Exact match, no numbers
    function.run "valid_word_abbreviation" {
      input = {
        word: "hello",
        abbr: "hello"
      }
    } as $result6
    debug.log { value = "Test 6 - word: 'hello', abbr: 'hello'" }
    debug.log { value = "Result: " ~ ($result6|to_text) }
    debug.log { value = "Expected: true" }
    
    // Compile all results
    var $all_results {
      value = {
        test1_internationalization: $result1,
        test2_apple: $result2,
        test3_hi: $result3,
        test4_leading_zero: $result4,
        test5_empty: $result5,
        test6_exact_match: $result6
      }
    }
  }
  
  response = $all_results
}
