// Run job to test the reverse-k-group function
run.job "Test Reverse Nodes in k-Group" {
  main = {
    name: "reverse_k_group"
    input: {
      list: [
        {val: 1, next: 1},
        {val: 2, next: 2},
        {val: 3, next: 3},
        {val: 4, next: 4},
        {val: 5, next: null}
      ]
      head_index: 0
      k: 2
    }
  }
}
