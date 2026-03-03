// Run job to test the min_add_to_make_valid function
run.job "Test Min Add to Make Valid" {
  main = {
    name: "min_add_to_make_valid"
    input: {
      s: "())"
    }
  }
}
