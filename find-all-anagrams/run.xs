// Run job to test the find_all_anagrams function
// Find All Anagrams: Find all start indices of pattern's anagrams in a string
run.job "Test Find All Anagrams" {
  main = {
    name: "find_all_anagrams"
    input: {
      s: "cbaebabacd"
      p: "abc"
    }
  }
}
