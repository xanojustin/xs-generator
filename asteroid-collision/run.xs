run.job "Asteroid Collision" {
  main = {
    name: "asteroid_collision"
    input: {
      asteroids: [5, 10, -5]
    }
  }
}
