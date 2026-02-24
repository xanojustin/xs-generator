// Array Partition - Run Job
// Given an array of 2n integers, group into n pairs to maximize sum of minimums
run.job "Array Partition Test" {
  main = {
    name: "array_partition"
    input: {
      nums: [1, 4, 3, 2]
    }
  }
}
