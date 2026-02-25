// Run job to test the height_checker function
// Tests various cases: normal case, already sorted, reverse sorted, all same height, single element
run.job "Test Height Checker" {
  main = {
    name: "height_checker"
    input: {
      heights: [1, 1, 4, 2, 1, 3]
    }
  }
}
