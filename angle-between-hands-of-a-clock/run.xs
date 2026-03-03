run.job "Angle Between Clock Hands" {
  main = {
    name: "calculate_clock_angle"
    input: {
      hour: 12
      minutes: 30
    }
  }
}
