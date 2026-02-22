// Run job to test the merge_two_sorted_lists function
// Merge Two Sorted Lists: Merges two sorted linked lists into one sorted linked list
run.job "Test Merge Two Sorted Lists" {
  main = {
    name: "merge_two_sorted_lists"
    input: {
      list1: [
        { value: 1, next: 1 },
        { value: 2, next: 2 },
        { value: 4, next: null }
      ]
      head1: 0
      list2: [
        { value: 1, next: 1 },
        { value: 3, next: 2 },
        { value: 4, next: null }
      ]
      head2: 0
    }
  }
}