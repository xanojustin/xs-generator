// Run job to test the add_two_numbers function
// Add Two Numbers: Adds two numbers represented as linked lists
run.job "Test Add Two Numbers" {
  main = {
    name: "add_two_numbers"
    input: {
      l1: [
        { value: 2, next: 1 },
        { value: 4, next: 2 },
        { value: 3, next: null }
      ]
      l2: [
        { value: 5, next: 1 },
        { value: 6, next: 2 },
        { value: 4, next: null }
      ]
      head1: 0
      head2: 0
    }
  }
}
