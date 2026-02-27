function "test_runner" {
  description = "Test runner for find_anagram_mappings function"
  
  input {
  }
  
  stack {
    // Test Case 1: Basic case from problem description
    function.run "find_anagram_mappings" {
      input = {
        nums1: [12, 28, 46, 32, 50],
        nums2: [50, 12, 32, 46, 28]
      }
    } as $test1_result
    
    debug.log { 
      value = "Test 1 - Basic: nums1=[12,28,46,32,50], nums2=[50,12,32,46,28]"
    }
    debug.log { value = "Result: " ~ ($test1_result|json_encode) }
    debug.log { value = "Expected: [1,4,3,2,0]" }
    
    // Test Case 2: Simple case with two elements
    function.run "find_anagram_mappings" {
      input = {
        nums1: [1, 2],
        nums2: [2, 1]
      }
    } as $test2_result
    
    debug.log { value = "" }
    debug.log { 
      value = "Test 2 - Simple swap: nums1=[1,2], nums2=[2,1]"
    }
    debug.log { value = "Result: " ~ ($test2_result|json_encode) }
    debug.log { value = "Expected: [1,0]" }
    
    // Test Case 3: With duplicates
    function.run "find_anagram_mappings" {
      input = {
        nums1: [1, 2, 1],
        nums2: [2, 1, 1]
      }
    } as $test3_result
    
    debug.log { value = "" }
    debug.log { 
      value = "Test 3 - With duplicates: nums1=[1,2,1], nums2=[2,1,1]"
    }
    debug.log { value = "Result: " ~ ($test3_result|json_encode) }
    debug.log { value = "Expected: [1,0,2] or [2,0,1] (both valid)" }
    
    // Test Case 4: Single element
    function.run "find_anagram_mappings" {
      input = {
        nums1: [42],
        nums2: [42]
      }
    } as $test4_result
    
    debug.log { value = "" }
    debug.log { 
      value = "Test 4 - Single element: nums1=[42], nums2=[42]"
    }
    debug.log { value = "Result: " ~ ($test4_result|json_encode) }
    debug.log { value = "Expected: [0]" }
    
    // Test Case 5: All same elements
    function.run "find_anagram_mappings" {
      input = {
        nums1: [5, 5, 5, 5],
        nums2: [5, 5, 5, 5]
      }
    } as $test5_result
    
    debug.log { value = "" }
    debug.log { 
      value = "Test 5 - All same: nums1=[5,5,5,5], nums2=[5,5,5,5]"
    }
    debug.log { value = "Result: " ~ ($test5_result|json_encode) }
    debug.log { value = "Expected: [0,1,2,3]" }
    
    // Store all results for response
    var $all_results { 
      value = {
        test1: $test1_result,
        test2: $test2_result,
        test3: $test3_result,
        test4: $test4_result,
        test5: $test5_result
      }
    }
  }
  
  response = $all_results
}
