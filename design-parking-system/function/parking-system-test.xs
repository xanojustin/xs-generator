function "parking-system-test" {
  description = "Run all parking system test cases"
  
  input {
  }
  
  stack {
    // Test Case 1: Big car with big spot available - should succeed
    function.run "parking-system" {
      input = { big: 1, medium: 0, small: 0, carType: 1 }
    } as $test1
    debug.log { value = "Test 1 (Big car in big spot): " ~ ($test1|to_text) }
    
    // Test Case 2: Medium car with medium spot available - should succeed
    function.run "parking-system" {
      input = { big: 0, medium: 1, small: 0, carType: 2 }
    } as $test2
    debug.log { value = "Test 2 (Medium car in medium spot): " ~ ($test2|to_text) }
    
    // Test Case 3: Small car with no small spots - should fail
    function.run "parking-system" {
      input = { big: 0, medium: 0, small: 0, carType: 3 }
    } as $test3
    debug.log { value = "Test 3 (Small car, no spots): " ~ ($test3|to_text) }
    
    // Test Case 4: Invalid car type (4) - should fail
    function.run "parking-system" {
      input = { big: 5, medium: 5, small: 5, carType: 4 }
    } as $test4
    debug.log { value = "Test 4 (Invalid car type): " ~ ($test4|to_text) }
    
    // Test Case 5: Small car with small spots available - should succeed
    function.run "parking-system" {
      input = { big: 0, medium: 0, small: 3, carType: 3 }
    } as $test5
    debug.log { value = "Test 5 (Small car with spots): " ~ ($test5|to_text) }
    
    // Test Case 6: Big car with no big spots - should fail
    function.run "parking-system" {
      input = { big: 0, medium: 2, small: 2, carType: 1 }
    } as $test6
    debug.log { value = "Test 6 (Big car, no big spots): " ~ ($test6|to_text) }
    
    // Test Case 7: Medium car with no medium spots - should fail
    function.run "parking-system" {
      input = { big: 1, medium: 0, small: 1, carType: 2 }
    } as $test7
    debug.log { value = "Test 7 (Medium car, no medium spots): " ~ ($test7|to_text) }
    
    var $results { value = {
      test1_big_car_available: $test1,
      test2_medium_car_available: $test2,
      test3_small_no_spots: $test3,
      test4_invalid_type: $test4,
      test5_small_car_available: $test5,
      test6_big_no_spots: $test6,
      test7_medium_no_spots: $test7
    } }
  }
  
  response = $results
}
