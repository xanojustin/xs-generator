// Run job to test the copy_list_with_random_pointer function
// Copy List with Random Pointer: Deep copy a linked list where each node has a random pointer
run.job "Test Copy List with Random Pointer" {
  main = {
    name: "copy_list_with_random_pointer"
    input: {
      nodes: [
        { value: 7, next: 1, random: null },
        { value: 13, next: 2, random: 0 },
        { value: 11, next: 3, random: 4 },
        { value: 10, next: 4, random: 2 },
        { value: 1, next: null, random: 0 }
      ],
      head_index: 0
    }
  }
}
