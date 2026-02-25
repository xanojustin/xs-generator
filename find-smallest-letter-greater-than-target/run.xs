// Run job to test the find_smallest_letter_greater_than_target function
// Find Smallest Letter Greater Than Target: Given a sorted array of letters and a target letter,
// return the smallest letter in the array that is larger than the target.
// If the target is greater than or equal to all letters, wrap around and return the first letter.
run.job "Test Find Smallest Letter Greater Than Target" {
  main = {
    name: "find_smallest_letter_greater_than_target"
    input: {
      letters: ["c", "f", "j"]
      target: "a"
    }
  }
}
