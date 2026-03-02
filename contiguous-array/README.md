# Contiguous Array

## Problem
Given a binary array `nums` (containing only 0s and 1s), find the longest contiguous subarray with an equal number of 0s and 1s.

### Example
- Input: `[0, 1]` → Output: `2` (the entire array has one 0 and one 1)
- Input: `[0, 1, 0]` → Output: `2` (subarray `[0, 1]` or `[1, 0]`)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_max_length.xs`):** Contains the solution logic using running sum + hash map

## Function Signature
- **Input:** `nums` - An array of integers (only 0s and 1s)
- **Output:** Integer representing the length of the longest contiguous subarray with equal 0s and 1s

## Algorithm Explanation
The solution uses a clever transformation and hash map approach:

1. **Transform:** Treat each 0 as -1 and each 1 as +1
2. **Running Sum:** Calculate cumulative sum as we iterate through the array
3. **Hash Map:** Store the first occurrence of each running sum
4. **Key Insight:** If the same running sum appears at index `i` and `j`, the subarray between them has equal 0s and 1s (because the sum is 0)

### Time Complexity
- **O(n)** - Single pass through the array

### Space Complexity
- **O(n)** - Hash map stores at most n unique sums

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[0, 1]` | `2` | Basic case: entire array has equal 0s and 1s |
| `[0, 1, 0]` | `2` | Longest subarray is `[0, 1]` or `[1, 0]` |
| `[0, 0, 1, 0, 0, 0, 1, 1]` | `6` | Subarray from index 1 to 6: `[0, 1, 0, 0, 0, 1]` has three 0s and three 1s |
| `[0, 0, 0]` | `0` | Edge case: no 1s, no valid subarray |
| `[1, 1, 1, 1]` | `0` | Edge case: no 0s, no valid subarray |
| `[]` | `0` | Edge case: empty array |
| `[0]` | `0` | Edge case: single element |
| `[0, 1, 1, 0, 1, 1, 1, 0]` | `4` | Subarray `[0, 1, 1, 0]` from index 0 to 3 |
