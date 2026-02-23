// Run job to test the firstBadVersion function
run.job "Test First Bad Version" {
  main = {
    name: "firstBadVersion"
    input: {
      n: 5
      firstBad: 4
    }
  }
}
