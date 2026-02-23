// Run job to test the is_interleave function
// Interleaving String: Determine if s3 is formed by interleaving s1 and s2
run.job "Test Interleaving String" {
  main = {
    name: "is_interleave"
    input: {
      s1: "aabcc"
      s2: "dbbca"
      s3: "aadbbcbcac"
    }
  }
}
