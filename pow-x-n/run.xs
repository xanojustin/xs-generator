// Run job to test the pow(x, n) function
// Tests various cases including positive, negative, and zero exponents
run.job "Test Pow(x, n)" {
  main = {
    name: "pow_x_n"
    input: {
      x: 2.0
      n: 10
    }
  }
}
