// Run job to test the valid_boomerang function
// Tests various point configurations including valid boomerangs, collinear points, and duplicates
run.job "Test Valid Boomerang" {
  main = {
    name: "valid_boomerang"
    input: {
      point1: { x: 1, y: 1 }
      point2: { x: 2, y: 3 }
      point3: { x: 3, y: 2 }
    }
  }
}
