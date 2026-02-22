# Longest Consecutive Sequence

## Problem
Given an unsorted array of integers `nums`, return the length of the longest consecutive elements sequence.

The algorithm must run in **O(n)** time complexity, where n is the number of elements in the array.

### Example
- Input: `[100, 4, 200, 1, 3, 2]`
- Output: `4`
- Explanation: The longest consecutive sequence is `[1, 2, 3, 4]`, which has length 4.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_consecutive_sequence.xs`):** Contains the O(n) solution using hash set

## Approach
1. **Hash Set Construction:** Convert the input array to a hash set (object with keys) for O(1) lookups
2. **Sequence Detection:** For each number, check if it's the start of a sequence (num - 1 not in set)
3. **Sequence Counting:** For sequence starts, count consecutive numbers until the sequence ends
4. **Max Tracking:** Keep track of the maximum sequence length found

This approach avoids sorting (which would be O(n log n)) and achieves O(n) time by only visiting each element a constant number of times.

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers (may contain duplicates, negative numbers, or be empty)
- **Output:** 
  - `int`: Length of the longest consecutive sequence (0 if array is empty)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[100, 4, 200, 1, 3, 2]` | `4` | Longest sequence is [1, 2, 3, 4] |
| `[0, 3, 7, 2, 5, 8, 4, 6, 0, 1]` | `9` | Longest sequence is [0, 1, 2, 3, 4, 5, 6, 7, 8] |
| `[]` | `0` | Empty array has no sequences |
| `[1]` | `1` | Single element forms a sequence of length 1 |
| `[1, 2, 0, 1]` | `3` | Duplicates are ignored, sequence is [0, 1, 2] |
| `[-5, -4, -3, 0, 1]` | `3` | Negative numbers work correctly, longest is [-5, -4, -3] |
| `[10, 5, 12]` | `1` | No consecutive numbers, each element is its own sequence |

## Complexity Analysis
- **Time Complexity:** O(n) - Each element is visited at most twice (once in the outer loop, once when counting its sequence)
- **Space Complexity:** O(n) - The hash set stores all unique elements
