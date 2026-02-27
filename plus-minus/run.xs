// Run job to test the plus-minus function
// Calculates ratios of positive, negative, and zero elements in an array
run.job "Test Plus Minus" {
  main = {
    name: "plus-minus"
    input: {
      arr: [-4, 3, -9, 0, 4, 1]
    }
  }
}
