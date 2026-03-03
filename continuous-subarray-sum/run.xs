run.job "Continuous Subarray Sum Checker" {
  main = {
    name: "check_subarray_sum"
    input: {
      nums: [23, 2, 4, 6, 7]
      k: 6
    }
  }
}
