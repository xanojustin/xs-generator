run.job "Evaluate RPN" {
  main = {
    name: "evaluate_rpn"
    input: {
      tokens: ["2", "1", "+", "3", "*"]
    }
  }
}
