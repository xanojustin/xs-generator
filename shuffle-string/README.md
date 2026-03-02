# Shuffle String

## Problem
You are given a string `s` and an integer array `indices` of the same length. The string `s` will be shuffled such that the character at the ith position moves to `indices[i]` in the shuffled string.

Return the shuffled string (i.e., restore the original string by placing each character at its target position).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shuffle_string.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): The shuffled string
  - `indices` (int[]): Array where indices[i] indicates the target position for s[i]
- **Output:**
  - (text): The restored string after shuffling characters to their correct positions

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| s="codeleet", indices=[4,5,6,7,0,2,1,3] | "leetcode" |
| s="abc", indices=[0,1,2] | "abc" |
| s="a", indices=[0] | "a" |
| s="abcd", indices=[3,2,1,0] | "dcba" |

### Test Case Explanations

1. **Basic case:** "codeleet" with indices [4,5,6,7,0,2,1,3] restores to "leetcode"
   - 'c' (index 0) goes to position 4
   - 'o' (index 1) goes to position 5
   - 'd' (index 2) goes to position 6
   - 'e' (index 3) goes to position 7
   - 'l' (index 4) goes to position 0
   - 'e' (index 5) goes to position 2
   - 'e' (index 6) goes to position 1
   - 't' (index 7) goes to position 3
   - Result: "leetcode"

2. **Already ordered:** String is already in correct order

3. **Single character:** Edge case with single character

4. **Reverse order:** Characters are placed in reverse positions
