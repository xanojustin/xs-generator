// Run job to test the majority-element-ii function
// Tests various cases including empty array, single element, and multiple candidates
run.job "Test Majority Element II" {
  main = {
    name: "majority_element_ii"
    input: {
      nums: [3, 2, 3]
    }
  }
}
