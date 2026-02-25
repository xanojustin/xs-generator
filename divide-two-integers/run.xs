// Run job to test the divide_integers function
// Divide Two Integers: Divide without using multiplication, division, or mod operators
run.job "Test Divide Two Integers" {
  main = {
    name: "divide_integers"
    input: {
      dividend: 10
      divisor: 3
    }
  }
}
