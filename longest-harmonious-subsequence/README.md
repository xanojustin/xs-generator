# Longest Harmonious Subsequence

## Problem
Given an integer array `nums`, return the length of the longest harmonious subsequence among all its possible subsequences.

A **harmonious array** is defined as an array where the difference between its maximum value and its minimum value is exactly `1`.

A **subsequence** is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_harmonious_subsequence.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers
- **Output:** 
  - Length of the longest harmonious subsequence (int)

## Algorithm
The solution uses a frequency counting approach:
1. Build a frequency map counting occurrences of each number
2. For each unique number, check if `number + 1` exists in the map
3. If it exists, the harmonious subsequence length is `count[number] + count[number + 1]`
4. Track and return the maximum length found

**Time Complexity:** O(n) where n is the length of the array
**Space Complexity:** O(n) for the frequency map

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 3, 2, 2, 5, 2, 3, 7]` | `5` | `[3, 2, 2, 2, 3]` or `[3, 2, 2, 3, 3]` - max=3, min=2, diff=1 |
| `[1, 2, 3, 4]` | `2` | Any two adjacent numbers form harmonious subsequence |
| `[1, 1, 1, 1]` | `0` | No number differs by exactly 1 |
| `[]` | `0` | Empty array has no harmonious subsequence |
| `[5]` | `0` | Single element has no harmonious subsequence |
| `[1, 2, 2, 3, 3, 3]` | `5` | `[2, 2, 3, 3, 3]` - two 2s and three 3s |

## Example Walkthrough

For input `[1, 3, 2, 2, 5, 2, 3, 7]`:
1. Build frequency map: `{1:1, 2:3, 3:2, 5:1, 7:1}`
2. Check each number:
   - 1: 1+1=2 exists → length = 1+3 = **4**
   - 3: 3+1=4 doesn't exist
   - 2: 2+1=3 exists → length = 3+2 = **5** ← max
   - 5: 5+1=6 doesn't exist
   - 7: 7+1=8 doesn't exist
3. Return max length: **5**