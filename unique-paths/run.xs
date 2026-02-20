run.job "unique-paths-test" {
  main = {
    name: "unique-paths"
    input: {
      rows: 2
      cols: 2
    }
  }
}
