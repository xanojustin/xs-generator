run.job "Two Sum Test" {
  main = {
    name: "two_sum"
    input: {
      numbers: [2, 7, 11, 15]
      target: 9
    }
  }
}
