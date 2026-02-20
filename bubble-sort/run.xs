// Run job to test the bubble sort function
run.job "Test Bubble Sort" {
  main = {
    name: "bubble_sort"
    input: {
      numbers: [64, 34, 25, 12, 22, 11, 90]
    }
  }
}
