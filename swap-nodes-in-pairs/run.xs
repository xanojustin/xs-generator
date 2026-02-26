// Run job to test the swap_nodes_in_pairs function
// Swap Nodes in Pairs: Swaps every two adjacent nodes in a linked list
run.job "Test Swap Nodes In Pairs" {
  main = {
    name: "swap_nodes_in_pairs"
    input: {
      list: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 3, next: 3 },
        { value: 4, next: null }
      ]
      head_index: 0
    }
  }
}
