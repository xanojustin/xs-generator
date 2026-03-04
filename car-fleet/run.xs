run.job "Car Fleet Calculator" {
  main = {
    name: "car_fleet"
    input: {
      target: 12
      position: [10, 8, 0, 5, 3]
      speed: [2, 4, 1, 1, 3]
    }
  }
}
