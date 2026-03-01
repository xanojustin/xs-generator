// Run job to test the kth_missing_positive_number function
// Kth Missing Positive Number: Find the kth positive integer missing from sorted array
run.job "Test Kth Missing Positive Number" {
  main = {
    name: "kth_missing_positive_number"
    input: {
      arr: [2, 3, 4, 7, 11]
      k: 5
    }
  }
}
