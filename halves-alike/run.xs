// Run job to test the halves_alike function
run.job "Test Halves Alike" {
  main = {
    name: "halves_alike"
    input: {
      s: "book"
    }
  }
}
