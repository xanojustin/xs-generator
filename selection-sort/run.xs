// Run job to test the selection sort function
// Selection Sort: Sorts an array by repeatedly finding the minimum element
run.job "Test Selection Sort" {
  main = {
    name: "selection_sort"
    input: {
      numbers: [64, 25, 12, 22, 11]
    }
  }
}
