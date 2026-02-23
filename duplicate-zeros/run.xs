run.job "Duplicate Zeros Test" {
  main = {
    name: "duplicate_zeros"
    input: {
      arr: [1, 0, 2, 3, 0, 4, 5, 0]
    }
  }
}
