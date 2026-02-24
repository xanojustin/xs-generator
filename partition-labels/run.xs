// Run job to test the partition_labels function
// Partition Labels: Partition string so each letter appears in at most one part
run.job "Test Partition Labels" {
  main = {
    name: "partition_labels"
    input: {
      s: "ababcbacadefegdehijhklij"
    }
  }
}
