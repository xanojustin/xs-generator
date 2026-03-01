run.job "add_operators_test" {
  main = {
    name: "add_operators"
    input: {
      num: "123"
      target: 6
    }
  }
}
