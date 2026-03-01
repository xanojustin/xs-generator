// Run job to test the bulb switcher function
run.job "Test Bulb Switcher" {
  main = {
    name: "bulb_switcher"
    input: {
      n: 3
    }
  }
}
