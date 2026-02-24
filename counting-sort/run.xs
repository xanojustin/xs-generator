// Run job to test the counting sort function
run.job "Test Counting Sort" {
  main = {
    name: "counting_sort"
    input: {
      arr: [4, 2, 2, 8, 3, 3, 1]
    }
  }
}
