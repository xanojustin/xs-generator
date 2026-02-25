run.job "Rod Cutting Problem" {
  main = {
    name: "rod_cutting"
    input: {
      prices: [1, 5, 8, 9, 10, 17, 17, 20]
      rod_length: 4
    }
  }
}
