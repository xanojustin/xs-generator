// Run job to test the middle_of_linked_list function
// Middle of the Linked List: Finds the middle node using slow/fast pointer technique
run.job "Test Middle of Linked List" {
  main = {
    name: "middle_of_linked_list"
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
