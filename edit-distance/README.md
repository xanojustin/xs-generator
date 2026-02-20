# Edit Distance (Levenshtein Distance)

## Problem

Calculate the minimum number of single-character operations (insertions, deletions, or substitutions) required to change one string into another. This is a classic dynamic programming problem known as the **Levenshtein distance**.

### Operations Allowed:
1. **Insert** a character
2. **Delete** a character  
3. **Replace** a character

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (`kitten` → `sitting`)
- **Function (`function/edit-distance.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `str1` (text): First string
  - `str2` (text): Second string
- **Output:**
  - Returns (int): The minimum edit distance between the two strings

## Algorithm

The solution uses a 2D dynamic programming matrix where:
- `dp[i][j]` represents the edit distance between `str1[0..i-1]` and `str2[0..j-1]`
- Base cases: First row/column represent distance from/to empty string
- Recurrence relation:
  - If characters match: `dp[i][j] = dp[i-1][j-1]` (no operation needed)
  - If characters differ: `dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1])`
    - `dp[i-1][j]`: Delete operation
    - `dp[i][j-1]`: Insert operation
    - `dp[i-1][j-1]`: Replace operation

## Test Cases

| Input str1 | Input str2 | Expected Output | Explanation |
|------------|------------|-----------------|-------------|
| `"kitten"` | `"sitting"` | `3` | k→s (replace), e→i (replace), +g (insert) |
| `"saturday"` | `"sunday"` | `3` | a→u (replace), delete t, delete r |
| `"abc"` | `"abc"` | `0` | Strings are identical |
| `""` | `"hello"` | `5` | Insert 5 characters into empty string |
| `"hello"` | `""` | `5` | Delete 5 characters to get empty string |
| `"a"` | `"b"` | `1` | Single character replacement |

### Complexity Analysis

- **Time Complexity:** O(m × n) where m and n are the lengths of the two strings
- **Space Complexity:** O(m × n) for the DP matrix

## Example Usage

```xs
// In a run job or another function
function.run "edit-distance" {
  input = {
    str1: "kitten"
    str2: "sitting"
  }
} as $result

// $result = 3
```
