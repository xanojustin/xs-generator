// Run job to test the queue_reconstruction function
// Queue Reconstruction by Height: Reconstruct the queue based on height and k values
run.job "Test Queue Reconstruction by Height" {
  main = {
    name: "queue_reconstruction"
    input: {
      people: [[7, 0], [4, 4], [7, 1], [5, 0], [6, 1], [5, 2]]
    }
  }
}
