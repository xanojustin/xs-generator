run.job "Set Mismatch" {
  main = {
    name: "find_set_mismatch"
    input: {
      nums: [1, 2, 2, 4]
    }
  }
}
