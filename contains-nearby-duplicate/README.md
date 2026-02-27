# Contains Nearby Duplicate

## Problem
Given an integer array `nums` and an integer `k`, return `true` if there are two distinct indices `i` and `j` in the array such that `nums[i] == nums[j]` and `abs(i - j) <= k`.

This problem tests the ability to use a hash map (simulated with an object in XanoScript) to track indices while iterating through an array, implementing a sliding window pattern.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/contains_nearby_duplicate.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): The array of integers to check
  - `k` (int): The maximum allowed distance between duplicate indices
- **Output:** 
  - `result` (bool): `true` if nearby duplicates exist, `false` otherwise

## Algorithm
The solution uses a hash map (object in XanoScript) to store the most recent index of each number seen:

1. Iterate through the array with an index counter
2. For each number, check if it exists in the index map
3. If it exists and `current_index - stored_index <= k`, return `true`
4. Otherwise, update the map with the current index
5. If no duplicates are found within range, return `false`

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(min(n, k)) - at most k+1 elements in the map

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `[1, 2, 3, 1]` | 3 | `true` |
| `[1, 0, 1, 1]` | 1 | `true` |
| `[1, 2, 3, 4, 5]` | 3 | `false` |
| `[]` | 0 | `false` |
| `[1]` | 0 | `false` |
| `[1, 1]` | 0 | `false` (distance is 1, which is > 0) |
| `[1, 1]` | 1 | `true` |

### Test Case Explanations

1. **Basic case with wrap-around:** `[1, 2, 3, 1]`, k=3 → `true` (1 appears at indices 0 and 3, distance is 3)
2. **Adjacent duplicates:** `[1, 0, 1, 1]`, k=1 → `true` (1 appears at indices 2 and 3, distance is 1)
3. **No duplicates:** `[1, 2, 3, 4, 5]`, k=3 → `false`
4. **Empty array:** `[]`, k=0 → `false` (edge case)
5. **Single element:** `[1]`, k=0 → `false` (edge case)
6. **Duplicates outside range:** `[1, 1]`, k=0 → `false` (distance is 1 > 0)
7. **Duplicates exactly at range:** `[1, 1]`, k=1 → `true` (distance is 1 <= 1)
