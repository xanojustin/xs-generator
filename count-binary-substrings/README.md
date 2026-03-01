# Count Binary Substrings

## Problem

Given a binary string (containing only '0's and '1's), count the number of substrings that have an equal number of consecutive 0s and consecutive 1s.

A valid substring must:
1. Have equal numbers of 0s and 1s
2. Have all 0s grouped consecutively and all 1s grouped consecutively

For example, "0011" is valid (two 0s followed by two 1s), but "0101" is not valid because the 0s and 1s are interleaved.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_binary_substrings.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `binary_string` (text): A string containing only '0' and '1' characters
- **Output:** 
  - (int): The count of valid binary substrings

## Algorithm

The solution uses a group-counting approach:
1. Count consecutive groups of identical characters
2. For each adjacent pair of groups (one 0s group, one 1s group), add `min(group1_length, group2_length)` to the result
3. This works because each valid substring must end at the boundary between two different groups

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| "00110011" | 6 | "0011", "01", "1100", "10", "0011", "01" |
| "10101" | 4 | "10", "01", "10", "01" |
| "000111" | 3 | "000111", "0011", "01" |
| "" | 0 | Empty string |
| "0" | 0 | Single character |
| "0000" | 0 | No alternating groups |
| "00100" | 2 | "01", "10" |

### Test Case Descriptions

1. **Standard case ("00110011"):** Multiple alternating groups of different sizes
2. **Alternating single chars ("10101"):** Every adjacent pair forms a valid substring
3. **Two groups only ("000111"):** Different length groups with overlapping valid substrings
4. **Edge case (""):** Empty string returns 0
5. **Edge case ("0"):** Single character has no valid substrings
6. **No alternation ("0000"):** All same characters, no valid substrings
7. **Partial overlap ("00100"):** Overlapping valid substrings at group boundaries
