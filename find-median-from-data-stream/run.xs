// Run job to test the find_median_from_data_stream function
// Find Median from Data Stream: Calculate running median after each number
run.job "Test Find Median From Data Stream" {
  main = {
    name: "find_median_from_data_stream"
    input: {
      stream: [5, 2, 8, 1, 7]
    }
  }
}
