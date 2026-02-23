// Run job to test the reorder_list function
// Reorder List: Reorders a linked list from L0→L1→...→Ln to L0→Ln→L1→Ln-1→L2→Ln-2→...
run.job "Test Reorder List" {
  main = {
    name: "reorder_list"
    input: {
      nodes: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 3, next: 3 },
        { value: 4, next: null }
      ]
      head_index: 0
    }
  }
}
