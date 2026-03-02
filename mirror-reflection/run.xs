// Run job to test the mirror_reflection function
// Tests various configurations of the mirrored room problem
run.job "Test Mirror Reflection" {
  main = {
    name: "mirror_reflection"
    input: {
      p: 2
      q: 1
    }
  }
}
