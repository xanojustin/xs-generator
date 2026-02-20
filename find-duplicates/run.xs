// Run job to test the find_duplicates function
run.job "Test Find Duplicates" {
  main = {
    name: "find_duplicates"
    input: {
      numbers: [1, 2, 3, 2, 4, 3, 5, 6, 1]
    }
  }
}
