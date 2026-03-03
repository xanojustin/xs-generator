# Scramble String

## Problem

Given two strings `s1` and `s2` of the same length, determine if `s2` is a scrambled version of `s1`.

A scrambled string is formed by the following recursive process:

1. **Base case:** If the string has length 1, it is only a scrambled version of itself
2. **Recursive case:** Split the string into two non-empty substrings at any position (there are n-1 possible splits for a string of length n)
3. **Scramble each part:** Recursively scramble the left and right substrings
4. **Optional swap:** You may choose to swap the two scrambled parts

### Example Walkthrough

For `s1 = "great"` and `s2 = "rgeat"`:
- Split "great" at position 2: "gr" | "eat"
- Scramble "gr" → "rg" (swap the two characters)
- Scramble "eat" → "eat" (no change needed)
- Combine: "rg" + "eat" = "rgeat" ✓

### More Examples

| s1 | s2 | Result | Explanation |
|----|----|----|----|
| "great" | "rgeat" | true | Split at 2, scramble "gr"→"rg", keep "eat" |
| "abcde" | "caebd" | true | Multiple splits and swaps |
| "a" | "a" | true | Single character |
| "ab" | "ba" | true | Simple swap |
| "abcd" | "bdac" | false | Cannot be formed by valid scrambles |

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/scramble_string.xs`):** Contains the recursive solution logic with optimizations

## Function Signature

- **Input:**
  - `s1` (text) - The original string
  - `s2` (text) - The string to check if it's a scrambled version of s1
- **Output:**
  - (bool) - `true` if s2 is a scrambled version of s1, `false` otherwise

## Test Cases

| s1 | s2 | Expected Output | Description |
|----|----|-----------------|-------------|
| "great" | "rgeat" | true | Basic scramble case |
| "abcde" | "caebd" | true | Multi-level scramble |
| "a" | "a" | true | Edge case: single character |
| "ab" | "ba" | true | Edge case: two characters, swapped |
| "abcd" | "bdac" | false | Edge case: invalid scramble |
| "abc" | "bca" | true | Valid rotation scramble |
| "abcdefghij" | "efghabcdij" | true | Larger string with internal scramble |

## Implementation Details

The solution uses a **recursive approach with early termination optimizations**:

1. **Length check:** If strings have different lengths, immediately return false
2. **Equality check:** If strings are equal, they are trivially scrambled versions
3. **Character count check:** Sort both strings and compare - if character frequencies differ, return false
4. **Recursive cases:** For each possible split point i:
   - **No swap:** Check if `s1[0:i]` scrambles to `s2[0:i]` AND `s1[i:]` scrambles to `s2[i:]`
   - **With swap:** Check if `s1[0:i]` scrambles to `s2[n-i:]` AND `s1[i:]` scrambles to `s2[0:n-i]`

### Time Complexity
- Worst case: O(n!) due to trying all possible splits
- With character count pruning: Much faster in practice

### Space Complexity
- O(n) for recursion stack depth
