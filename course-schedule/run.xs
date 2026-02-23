// Run job to test the can_finish function
// Course Schedule: Determine if all courses can be completed given prerequisites
run.job "Test Course Schedule" {
  main = {
    name: "can_finish"
    input: {
      num_courses: 2
      prerequisites: [[1, 0]]
    }
  }
}
