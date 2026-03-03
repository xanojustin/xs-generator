// Run job to test the odd_even_linked_list function
// Odd Even Linked List: Groups odd-positioned nodes before even-positioned nodes
run.job "Test Odd Even Linked List" {
  main = {
    name: "odd_even_linked_list"
    input: {
      nodes: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 3, next: 3 },
        { value: 4, next: 4 },
        { value: 5, next: null }
      ]
      head_index: 0
    }
  }
}
