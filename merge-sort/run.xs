// Run job to test the merge_sort function
// Merge Sort: Sorts an array using the divide-and-conquer merge sort algorithm
run.job "Test Merge Sort" {
  main = {
    name: "merge_sort"
    input: {
      numbers: [64, 34, 25, 12, 22, 11, 90]
    }
  }
}
