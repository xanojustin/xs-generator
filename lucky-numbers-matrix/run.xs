run.job "Find Lucky Numbers" {
  main = {
    name: "lucky_numbers"
    input: {
      matrix: {
        rows: [
          [3, 7, 8],
          [9, 11, 13],
          [15, 16, 17]
        ]
      }
    }
  }
}
