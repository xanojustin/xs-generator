run.job "LCIS Test" {
  main = {
    name: "lcis"
    input: {
      nums: [1, 3, 5, 4, 7]
    }
  }
}
