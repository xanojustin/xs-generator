function "run-bucket-sort-tests" {
  description = "Runs multiple test cases for bucket sort and returns all results"
  
  input {
  }
  
  stack {
    var $test_results { value = [] }
    
    // Test Case 1: Basic unsorted array
    function.run "bucket-sort" {
      input = {
        numbers: [0.78, 0.17, 0.39, 0.26, 0.72, 0.94, 0.21, 0.12, 0.23, 0.68],
        bucket_count: 5
      }
    } as $result1
    var.update $test_results { value = $test_results ~ [{test: "Basic unsorted array", input: [0.78, 0.17, 0.39, 0.26, 0.72, 0.94, 0.21, 0.12, 0.23, 0.68], output: $result1}] }
    
    // Test Case 2: Already sorted array
    function.run "bucket-sort" {
      input = {
        numbers: [0.1, 0.2, 0.3, 0.4, 0.5],
        bucket_count: 3
      }
    } as $result2
    var.update $test_results { value = $test_results ~ [{test: "Already sorted array", input: [0.1, 0.2, 0.3, 0.4, 0.5], output: $result2}] }
    
    // Test Case 3: Reverse sorted array
    function.run "bucket-sort" {
      input = {
        numbers: [0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1],
        bucket_count: 5
      }
    } as $result3
    var.update $test_results { value = $test_results ~ [{test: "Reverse sorted array", input: [0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1], output: $result3}] }
    
    // Test Case 4: Empty array (edge case)
    function.run "bucket-sort" {
      input = {
        numbers: [],
        bucket_count: 5
      }
    } as $result4
    var.update $test_results { value = $test_results ~ [{test: "Empty array", input: [], output: $result4}] }
    
    // Test Case 5: Single element
    function.run "bucket-sort" {
      input = {
        numbers: [0.5],
        bucket_count: 3
      }
    } as $result5
    var.update $test_results { value = $test_results ~ [{test: "Single element", input: [0.5], output: $result5}] }
    
    // Test Case 6: All same values
    function.run "bucket-sort" {
      input = {
        numbers: [0.5, 0.5, 0.5, 0.5, 0.5],
        bucket_count: 4
      }
    } as $result6
    var.update $test_results { value = $test_results ~ [{test: "All same values", input: [0.5, 0.5, 0.5, 0.5, 0.5], output: $result6}] }
    
    // Test Case 7: Large range with default bucket count
    function.run "bucket-sort" {
      input = {
        numbers: [0.01, 0.99, 0.5, 0.25, 0.75]
      }
    } as $result7
    var.update $test_results { value = $test_results ~ [{test: "Large range with default buckets", input: [0.01, 0.99, 0.5, 0.25, 0.75], output: $result7}] }
  }
  
  response = $test_results
}
