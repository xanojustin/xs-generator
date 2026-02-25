# Letter Case Permutation

## Problem
Given a string `S`, we can transform every letter individually to be lowercase or uppercase to create another string. Return a list of all possible strings we could create.

**Key Points:**
- Letters can be transformed to lowercase or uppercase
- Digits remain unchanged
- The order of results doesn't matter
- If the string contains no letters, return the original string in a list

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/letter_case_permutation.xs`):** Contains the solution logic using iterative backtracking

## Function Signature
- **Input:**
  - `s` (text): Input string containing letters and/or digits
- **Output:**
  - Returns an array of text strings - all possible case permutations

## Algorithm
The solution uses iterative backtracking (stack-based DFS) to explore all possibilities:
1. Convert the input string to an array of characters
2. Identify which positions contain letters (vs digits)
3. Use a stack to simulate recursion, where each stack item tracks:
   - `current`: The string built so far
   - `pos`: The current position being processed
4. For each character:
   - If it's a digit, simply append it and continue
   - If it's a letter, create two branches (lowercase and uppercase)
5. When all positions are processed, add the result

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"a1b2"` | `["a1b2", "a1B2", "A1b2", "A1B2"]` |
| `"3z4"` | `["3z4", "3Z4"]` |
| `"12345"` | `["12345"]` (no letters, so only original) |
| `""` | `[""]` (empty string edge case) |
| `"ab"` | `["ab", "aB", "Ab", "AB"]` (all letters) |

## Complexity Analysis
- **Time Complexity:** O(2^N × N) where N is the number of letters in the string
  - Each letter creates 2 branches
  - Building each result string takes O(N) time
- **Space Complexity:** O(2^N × N) for storing all results plus O(N) for the stack
