// Run job to test the rotate_list function
// Rotate List: Rotate a linked list to the right by k places
run.job "Test Rotate List" {
  main = {
    name: "rotate_list"
    input: {
      head: [1, 2, 3, 4, 5]
      k: 2
    }
  }
}
