// Run job to test unique_number_of_occurrences function
run.job "Test Unique Number of Occurrences" {
  main = {
    name: "unique_number_of_occurrences"
    input: {
      arr: [1, 2, 2, 1, 1, 3]
    }
  }
}
