// Run job to test the insertion sort function
run.job "Test Insertion Sort" {
  main = {
    name: "insertion_sort"
    input: {
      numbers: [64, 34, 25, 12, 22, 11, 90]
    }
  }
}
