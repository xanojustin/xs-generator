// Run job to test the linked_list_cycle function
// Linked List Cycle Detection: Detects if a linked list contains a cycle using Floyd's algorithm
// Test case: List with cycle (node 3 points back to node 1)
// 0: {value: 3, next: 1}
// 1: {value: 2, next: 2}
// 2: {value: 0, next: 3}
// 3: {value: -4, next: 1}  <- creates cycle
run.job "Test Linked List Cycle Detection" {
  main = {
    name: "linked_list_cycle"
    input: {
      nodes: [
        { value: 3, next: 1 }
        { value: 2, next: 2 }
        { value: 0, next: 3 }
        { value: -4, next: 1 }
      ]
    }
  }
}
