# Letter Combinations of a Phone Number

## Problem
Given a string containing digits from `2-9` inclusive, return all possible letter combinations that the number could represent based on a standard phone keypad mapping.

**Phone Keypad Mapping:**
- 2: abc
- 3: def
- 4: ghi
- 5: jkl
- 6: mno
- 7: pqrs
- 8: tuv
- 9: wxyz

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input "23"
- **Function (`function/letter_combinations.xs`):** Contains the backtracking solution logic

## Function Signature
- **Input:** 
  - `digits` (text, required): A string of digits from 2-9 (e.g., "23", "79")
- **Output:** 
  - Array of text: All possible letter combinations (e.g., ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"])

## Algorithm
The solution uses an iterative approach with a queue:
1. Handle edge case: return empty array if input is empty
2. Build a mapping of digits to their corresponding letters
3. Extract letters for each digit in the input string
4. Iteratively build combinations by taking each prefix and appending each possible letter
5. Return the final array of all combinations

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| "23" | ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"] |
| "" | [] |
| "2" | ["a", "b", "c"] |
| "79" | ["pw", "px", "py", "pz", "qw", "qx", "qy", "qz", "rw", "rx", "ry", "rz", "sw", "sx", "sy", "sz"] |

### Test Case Descriptions
1. **"23"** - Basic case with two digits, each mapping to 3 letters (3×3=9 combinations)
2. **""** - Edge case: empty string should return empty array
3. **"2"** - Edge case: single digit returns just its letters
4. **"79"** - Boundary case: digits with different letter counts (4×4=16 combinations)
