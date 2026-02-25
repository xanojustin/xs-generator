// Run job to test the zigzag conversion function
run.job "Test Zigzag Conversion" {
  main = {
    name: "zigzag_convert"
    input: {
      input_string: "PAYPALISHIRING"
      num_rows: 3
    }
  }
}
