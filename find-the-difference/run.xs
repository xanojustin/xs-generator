run.job "Find the Difference Test" {
  main = {
    name: "find_the_difference"
    input: {
      s: "abcd"
      t: "abcde"
    }
  }
}
