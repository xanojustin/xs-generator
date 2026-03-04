run.job "Count Good Triplets" {
  main = {
    name: "count_good_triplets"
    input: {
      arr: [3, 0, 1, 1, 9, 7]
      a: 7
      b: 2
      c: 3
    }
  }
}
