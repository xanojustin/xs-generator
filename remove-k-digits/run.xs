run.job "Remove K Digits Test" {
  main = {
    name: "remove_k_digits"
    input: {
      num: "1432219"
      k: 3
    }
  }
}
