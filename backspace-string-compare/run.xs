// Run job to test the backspace_compare function
run.job "Test Backspace String Compare" {
  main = {
    name: "backspace_compare"
    input: {
      s: "ab#c"
      t: "ad#c"
    }
  }
}
