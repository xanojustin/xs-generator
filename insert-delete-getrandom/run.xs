run.job "Insert Delete GetRandom Test" {
  main = {
    name: "randomized_set"
    input: {
      operations: ["insert", "insert", "insert", "getRandom", "remove", "getRandom", "insert", "remove", "insert"],
      values: [1, 2, 3, null, 2, null, 2, 2, 4]
    }
  }
}