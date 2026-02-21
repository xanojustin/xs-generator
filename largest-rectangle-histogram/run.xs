// Run job to test the largest_rectangle_histogram function
// Largest Rectangle in Histogram: Find the largest rectangle area
run.job "Test Largest Rectangle Histogram" {
  main = {
    name: "largest_rectangle_histogram"
    input: {
      heights: [2, 1, 5, 6, 2, 3]
    }
  }
}
