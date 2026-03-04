run.job "Range Addition Test" {
  main = {
    name: "range_addition"
    input: {
      length: 5
      updates: [[1, 3, 2], [2, 4, 3], [0, 2, -1]]
    }
  }
}
