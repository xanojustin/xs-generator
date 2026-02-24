// Run job to test the range_sum_query function
run.job "Test Range Sum Query" {
  main = {
    name: "range_sum_query"
    input: {
      nums: [-2, 0, 3, -5, 2, -1]
      left: 0
      right: 2
    }
  }
}
