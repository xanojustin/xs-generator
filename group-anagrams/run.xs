// Run job to test the group_anagrams function
run.job "Test Group Anagrams" {
  main = {
    name: "group_anagrams"
    input: {
      strings: ["eat", "tea", "tan", "ate", "nat", "bat"]
    }
  }
}
