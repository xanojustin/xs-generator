// Run job to test the sort_list function
// Sort List: Sort a linked list in O(n log n) time using merge sort
run.job "Test Sort List" {
  main = {
    name: "sort_list"
    input: {
      nodes: [
        { value: 4, next: 1 },
        { value: 2, next: 2 },
        { value: 1, next: 3 },
        { value: 3, next: null }
      ]
      head_index: 0
    }
  }
}
