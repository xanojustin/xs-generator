// Run job to test the Tower of Hanoi function
run.job "Test Tower of Hanoi" {
  main = {
    name: "tower_of_hanoi"
    input: {
      num_disks: 3
    }
  }
}
