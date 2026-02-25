run.job "Koko Eating Bananas" {
  main = {
    name: "koko_eating_bananas"
    input: {
      piles: [3, 6, 7, 11]
      h: 8
    }
  }
}
