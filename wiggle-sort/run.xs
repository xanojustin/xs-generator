// Run job to test the wiggle_sort function
run.job "Test Wiggle Sort" {
  main = {
    name: "wiggle_sort"
    input: {
      nums: [3, 5, 2, 1, 6, 4]
    }
  }
}
