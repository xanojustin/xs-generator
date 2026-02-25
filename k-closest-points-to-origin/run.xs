run.job "K Closest Points to Origin" {
  main = {
    name: "k_closest_points"
    input: {
      points: [
        { x: 1, y: 3 },
        { x: -2, y: 2 },
        { x: 3, y: 3 },
        { x: 4, y: -1 },
        { x: 0, y: 1 }
      ]
      k: 2
    }
  }
}
