run.job "Remove Element Test" {
  main = {
    name: "remove_element"
    input: {
      nums: [3, 2, 2, 3]
      val: 3
    }
  }
}
