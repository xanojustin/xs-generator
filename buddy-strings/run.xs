// Run job to test the buddy_strings function
run.job "Buddy Strings Test" {
  main = {
    name: "buddy_strings"
    input: {
      s: "ab"
      goal: "ba"
    }
  }
}
