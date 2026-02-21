// Run job to test the container_with_most_water function
// Container With Most Water: Find two lines that form a container holding the most water
run.job "Test Container With Most Water" {
  main = {
    name: "container_with_most_water"
    input: {
      heights: [1, 8, 6, 2, 5, 4, 8, 3, 7]
    }
  }
}
