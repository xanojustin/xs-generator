run.job "Evaluate Division Test" {
  main = {
    name: "evaluate_division"
    input: {
      equations: [["a", "b"], ["b", "c"]],
      values: [2.0, 3.0],
      queries: [["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"]]
    }
  }
}
