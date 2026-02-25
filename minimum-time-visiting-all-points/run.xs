// Run job to test the minimum-time-visiting-all-points function
run.job "Test Minimum Time Visiting All Points" {
  main = {
    name: "minimum-time-visiting-all-points"
    input: {
      points: [[1, 1], [3, 4], [-1, 0]]
    }
  }
}
