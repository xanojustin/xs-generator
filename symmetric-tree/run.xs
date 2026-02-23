run.job "Symmetric Tree Check" {
  main = {
    name: "is_symmetric"
    input: {
      tree: [1, 2, 2, 3, 4, 4, 3]
    }
  }
}
