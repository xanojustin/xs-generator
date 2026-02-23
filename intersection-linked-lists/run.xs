// Run job to test the intersection_linked_lists function
// Finds the intersection node of two singly linked lists
// Lists are represented as arrays with index-based next pointers
run.job "Test Intersection of Two Linked Lists" {
  main = {
    name: "intersection_linked_lists"
    input: {
      list_a: [
        { val: 4, next: 1 },
        { val: 1, next: 2 },
        { val: 8, next: 3 },
        { val: 4, next: 4 },
        { val: 5, next: null }
      ]
      head_a: 0
      list_b: [
        { val: 5, next: 1 },
        { val: 6, next: 2 },
        { val: 8, next: 3 },
        { val: 4, next: 4 },
        { val: 5, next: null }
      ]
      head_b: 0
    }
  }
}
