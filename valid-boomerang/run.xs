run.job "Valid Boomerang Test" {
  main = {
    name: "valid-boomerang"
    input: {
      points: [
        { x: 1, y: 1 }
        { x: 2, y: 3 }
        { x: 3, y: 2 }
      ]
    }
  }
}
