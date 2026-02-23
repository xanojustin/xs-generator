// Run job to test the find_k_closest_elements function
// Find K Closest Elements: Given a sorted array, find k elements closest to target x
run.job "Test Find K Closest Elements" {
  main = {
    name: "find_k_closest_elements"
    input: {
      arr: [1, 2, 3, 4, 5]
      k: 4
      x: 3
    }
  }
}
