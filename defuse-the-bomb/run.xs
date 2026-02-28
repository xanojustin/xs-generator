run.job "Defuse the Bomb" {
  main = {
    name: "defuse_bomb"
    input: {
      code: [5, 7, 1, 4]
      k: 3
    }
  }
}
