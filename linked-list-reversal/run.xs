// Run job to test the reverse_linked_list function
// Linked List Reversal: Reverses a singly linked list
run.job "Test Linked List Reversal" {
  main = {
    name: "reverse_linked_list"
    input: {
      list: [
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
