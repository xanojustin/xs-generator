// Run job to test the remove_nth_node_from_end function
// Remove Nth Node From End of List: Removes the nth node from the end of a linked list
run.job "Test Remove Nth Node From End" {
  main = {
    name: "remove_nth_node_from_end"
    input: {
      nodes: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 3, next: 3 },
        { value: 4, next: 4 },
        { value: 5, next: null }
      ]
      head: 0
      n: 2
    }
  }
}