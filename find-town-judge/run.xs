run.job "Find Town Judge Test" {
  main = {
    name: "find_town_judge"
    input: {
      n: 2
      trust: [[1, 2]]
    }
  }
}
