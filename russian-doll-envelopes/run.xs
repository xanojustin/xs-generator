run.job "Russian Doll Envelopes" {
  main = {
    name: "max_russian_dolls"
    input: {
      envelopes: [
        [5, 4],
        [6, 4],
        [6, 7],
        [2, 3]
      ]
    }
  }
}
