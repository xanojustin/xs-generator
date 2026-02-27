// Run job to test the heap_sort function
// Heap Sort: Sorts an array using a binary heap data structure
run.job "Test Heap Sort" {
  main = {
    name: "heap_sort"
    input: {
      numbers: [64, 34, 25, 12, 22, 11, 90, 5, 77, 43]
    }
  }
}
