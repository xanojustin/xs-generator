// Run job to test the smallest_difference function
run.job "Test Smallest Difference" {
  main = {
    name: "smallest_difference"
    input: {
      array1: [-1, 5, 10, 20, 28, 3]
      array2: [26, 134, 135, 15, 17]
    }
  }
}
