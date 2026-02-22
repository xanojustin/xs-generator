run.job "Rotate Image" {
  main = {
    name: "rotate_image"
    input: {
      matrix: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
  }
}
