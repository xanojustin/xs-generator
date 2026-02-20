// Run job to test the word_ladder function
run.job "Test Word Ladder" {
  main = {
    name: "word_ladder"
    input: {
      begin_word: "hit"
      end_word: "cog"
      word_list: ["hot", "dot", "dog", "lot", "log", "cog"]
    }
  }
}
