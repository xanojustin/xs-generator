run.job "Anagram Detection Test" {
  main = {
    name: "anagram-detection"
    input: {
      str1: "listen"
      str2: "silent"
    }
  }
}
