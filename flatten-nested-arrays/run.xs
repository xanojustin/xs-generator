run.job "Flatten Nested Arrays Test" {
  main = {
    name: "flatten_array"
    input: {
      nested_array: [1, [2, 3], [[4, 5], 6], [7, [8, [9]]]]
    }
  }
}
