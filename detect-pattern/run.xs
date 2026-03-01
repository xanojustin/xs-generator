run.job "Detect Pattern" {
  main = {
    name: "detect_pattern"
    input: {
      arr: [1, 2, 4, 4, 4, 4]
      m: 1
      k: 3
    }
  }
}
