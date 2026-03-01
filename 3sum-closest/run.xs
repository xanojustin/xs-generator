// Run job to test the three_sum_closest function
// 3Sum Closest: Find three integers whose sum is closest to target
run.job "Test 3Sum Closest" {
  main = {
    name: "three_sum_closest"
    input: {
      nums: [-1, 2, 1, -4]
      target: 1
    }
  }
}
