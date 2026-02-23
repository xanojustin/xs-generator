// Run job to test the binary_to_decimal function
run.job "Binary to Decimal Converter" {
  main = {
    name: "binary_to_decimal"
    input: {
      binary_string: "101010"
    }
  }
}
