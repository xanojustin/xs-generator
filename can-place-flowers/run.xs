// Run job to test the can_place_flowers function
// Can Place Flowers: Determine if n flowers can be planted without being adjacent
run.job "Test Can Place Flowers" {
  main = {
    name: "can_place_flowers"
    input: {
      flowerbed: [1, 0, 0, 0, 1]
      n: 1
    }
  }
}
