// Run job to test the remove_linked_list_elements function
// Remove Linked List Elements: Removes all nodes with the specified value from a linked list
run.job "Test Remove Linked List Elements" {
  main = {
    name: "remove_linked_list_elements"
    input: {
      nodes: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 6, next: 3 },
        { value: 3, next: 4 },
        { value: 4, next: 5 },
        { value: 6, next: null }
      ]
      head: 0
      val: 6
    }
  }
}
