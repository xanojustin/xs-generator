// Run job for Maximal Square exercise
run.job "Maximal Square Test" {
  main = {
    name: "maximal_square"
    input: {
      matrix: [
        [1, 0, 1, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 1, 0]
      ]
    }
  }
}
