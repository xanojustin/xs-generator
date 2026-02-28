run.job "Chunk Array Exercise" {
  main = {
    name: "chunk_array"
    input: {
      array: [1, 2, 3, 4, 5, 6, 7, 8]
      size: 3
    }
  }
}
