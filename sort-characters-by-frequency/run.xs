// Run job to test the sort-characters-by-frequency function
// Sort Characters By Frequency: Sorts characters by frequency in descending order
run.job "Test Sort Characters By Frequency" {
  main = {
    name: "sort-characters-by-frequency"
    input: {
      input_string: "tree"
    }
  }
}
