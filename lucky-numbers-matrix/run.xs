// Run job to test the lucky-numbers-matrix function
run.job "Test Lucky Numbers Matrix" {
  main = {
    name: "lucky-numbers-matrix"
    input: {
      matrix: [
        [3, 7, 8],
        [9, 11, 13],
        [15, 16, 17]
      ]
    }
  }
}
