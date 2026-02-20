run.job "Word Break Test" {
  main = {
    name: "word_break"
    input: {
      s: "leetcode"
      wordDict: ["leet", "code"]
    }
  }
}
