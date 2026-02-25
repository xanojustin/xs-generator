run.job "H-Index Calculator" {
  main = {
    name: "h_index"
    input: {
      citations: [3, 0, 6, 1, 5]
    }
  }
}
