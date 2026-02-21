run.job "Plus One Test" {
  main = {
    name: "plus_one"
    input: {
      digits: [1, 2, 3]
    }
  }
}
