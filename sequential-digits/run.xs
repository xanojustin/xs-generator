// Run job to test the sequential_digits function
// Sequential Digits: Find all numbers in range [low, high] where each digit
// is exactly one more than the previous digit (e.g., 123, 4567, 2345)
run.job "Test Sequential Digits" {
  main = {
    name: "sequential_digits"
    input: {
      low: 100
      high: 300
    }
  }
}
