function "product-of-array-except-self-test" {
  description = "Test harness for product-of-array-except-self that runs multiple test cases"
  
  input {
  }
  
  stack {
    // Test case 1: Basic case with positive numbers
    function.run "product-of-array-except-self" {
      input = { numbers: [1, 2, 3, 4] }
    } as $result1
    
    // Test case 2: Array with zeros
    function.run "product-of-array-except-self" {
      input = { numbers: [1, 0, 3, 4] }
    } as $result2
    
    // Test case 3: Single element
    function.run "product-of-array-except-self" {
      input = { numbers: [5] }
    } as $result3
    
    // Test case 4: Two elements
    function.run "product-of-array-except-self" {
      input = { numbers: [2, 3] }
    } as $result4
    
    // Test case 5: Empty array
    function.run "product-of-array-except-self" {
      input = { numbers: [] }
    } as $result5
    
    // Test case 6: Negative numbers
    function.run "product-of-array-except-self" {
      input = { numbers: [-1, 1, 0, -3, 3] }
    } as $result6
    
    // Compile all results
    var $test_results {
      value = {
        test1: { input: [1, 2, 3, 4], output: $result1, expected: [24, 12, 8, 6], pass: ($result1 == [24, 12, 8, 6]) },
        test2: { input: [1, 0, 3, 4], output: $result2, expected: [0, 12, 0, 0], pass: ($result2 == [0, 12, 0, 0]) },
        test3: { input: [5], output: $result3, expected: [1], pass: ($result3 == [1]) },
        test4: { input: [2, 3], output: $result4, expected: [3, 2], pass: ($result4 == [3, 2]) },
        test5: { input: [], output: $result5, expected: [], pass: ($result5 == []) },
        test6: { input: [-1, 1, 0, -3, 3], output: $result6, expected: [0, 0, 9, 0, 0], pass: ($result6 == [0, 0, 9, 0, 0]) }
      }
    }
  }
  
  response = $test_results
}