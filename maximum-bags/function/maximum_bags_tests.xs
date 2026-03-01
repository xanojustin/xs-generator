// Test function for maximum_bags
// Runs multiple test cases and returns all results
function "maximum_bags_tests" {
  description = "Run multiple test cases for maximum_bags function"
  
  input {
  }
  
  stack {
    // Test case 1: Basic case
    function.run "maximum_bags" {
      input = {
        capacity: [2, 3, 4, 5],
        rocks: [1, 2, 4, 4],
        additionalRocks: 2
      }
    } as $result1
    debug.log { value = "Test 1: capacity=[2,3,4,5], rocks=[1,2,4,4], additional=2. Expected 3, Got " ~ ($result1|to_text) }
    
    // Test case 2: All bags can be filled
    function.run "maximum_bags" {
      input = {
        capacity: [10, 2, 2],
        rocks: [2, 2, 0],
        additionalRocks: 100
      }
    } as $result2
    debug.log { value = "Test 2: capacity=[10,2,2], rocks=[2,2,0], additional=100. Expected 3, Got " ~ ($result2|to_text) }
    
    // Test case 3: No additional rocks
    function.run "maximum_bags" {
      input = {
        capacity: [5, 5, 5],
        rocks: [5, 5, 5],
        additionalRocks: 0
      }
    } as $result3
    debug.log { value = "Test 3: All full, no additional. Expected 3, Got " ~ ($result3|to_text) }
    
    // Test case 4: Edge case - single bag
    function.run "maximum_bags" {
      input = {
        capacity: [10],
        rocks: [5],
        additionalRocks: 3
      }
    } as $result4
    debug.log { value = "Test 4: Single bag, not enough rocks. Expected 0, Got " ~ ($result4|to_text) }
    
    // Test case 5: Edge case - single bag, exact match
    function.run "maximum_bags" {
      input = {
        capacity: [10],
        rocks: [5],
        additionalRocks: 5
      }
    } as $result5
    debug.log { value = "Test 5: Single bag, exact match. Expected 1, Got " ~ ($result5|to_text) }
    
    // Test case 6: Partial fill - need to skip some
    function.run "maximum_bags" {
      input = {
        capacity: [3, 3, 3],
        rocks: [1, 1, 1],
        additionalRocks: 3
      }
    } as $result6
    debug.log { value = "Test 6: capacity=[3,3,3], rocks=[1,1,1], additional=3. Expected 1 (can fill 1.5, so only 1 full), Got " ~ ($result6|to_text) }
    
    // Collect all results
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
