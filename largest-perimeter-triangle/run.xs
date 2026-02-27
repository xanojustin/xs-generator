// Run job to test the largest_perimeter_triangle function
// Tests with various input arrays to find the largest valid triangle perimeter
run.job "Test Largest Perimeter Triangle" {
  main = {
    name: "largest_perimeter_triangle"
    input: {
      sides: [3, 6, 2, 3]
    }
  }
}
