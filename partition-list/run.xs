// Run job to test the partition_list function
run.job "Test Partition List" {
  main = {
    name: "partition_list"
    input: {
      head: [1, 4, 3, 2, 5, 2]
      x: 3
    }
  }
}
