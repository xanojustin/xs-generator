// Run job to test the fizzbuzz function
run.job "Test FizzBuzz" {
  main = {
    name: "fizzbuzz"
    input: {
      n: 15
    }
  }
}
