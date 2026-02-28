// Run job to test the min_genetic_mutation function
// Minimum Genetic Mutation: Find minimum mutations from start gene to end gene
run.job "Test Minimum Genetic Mutation" {
  main = {
    name: "min_genetic_mutation"
    input: {
      start: "AACCGGTT"
      end: "AACCGGTA"
      bank: ["AACCGGTA"]
    }
  }
}
