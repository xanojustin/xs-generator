run.job "Find Good Days Test" {
  main = {
    name: "good_days"
    input: {
      security: [5, 3, 3, 3, 5, 6, 2]
      time: 2
    }
  }
}
