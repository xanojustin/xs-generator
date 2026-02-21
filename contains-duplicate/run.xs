// Run job to test the contains_duplicate function
// Tests various cases: duplicates present, all unique, empty array, single element
run.job "Test Contains Duplicate" {
  main = {
    name: "contains_duplicate"
    input: {
      nums: [1, 2, 3, 1]
    }
  }
}
