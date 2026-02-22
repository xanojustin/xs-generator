# Jump Game II

## Problem

You are given a **0-indexed** array of integers `nums` of length `n`. You are initially positioned at `nums[0]`.

Each element `nums[i]` represents the maximum length of a forward jump from index `i`. In other words, if you are at `nums[i]`, you can jump to any `nums[i + j]` where:
- `0 <= j <= nums[i]`
- `i + j < n`

Return the **minimum number of jumps** to reach `nums[n - 1]`. The test cases are generated such that you can reach `nums[n - 1]`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/jumpGame2.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): Array where each element represents the maximum jump length from that position
- **Output:** 
  - `int`: Minimum number of jumps to reach the last index, or -1 if impossible

## Algorithm

This solution uses a **greedy algorithm** with O(n) time complexity:

1. Track three variables:
   - `jumps`: Number of jumps made so far
   - `currentEnd`: The farthest index reachable with current number of jumps
   - `farthest`: The farthest index reachable with one more jump

2. Iterate through the array (except the last element):
   - At each position, update `farthest` to be the maximum of its current value and `i + nums[i]`
   - When we reach `currentEnd`, we must make another jump:
     - Increment `jumps`
     - Update `currentEnd` to `farthest`
     - If `currentEnd` reaches or exceeds the last index, return `jumps`

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(1) - only a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 3, 1, 1, 4]` | `2` | Jump 1 step from index 0 to 1, then 3 steps to last index |
| `[2, 3, 0, 1, 4]` | `2` | Same path works despite the 0 at index 2 |
| `[1, 1, 1, 1]` | `3` | Must hop one step at a time |
| `[0]` | `0` | Already at last index (single element) |
| `[2, 0]` | `1` | One jump from index 0 to index 1 |
| `[1, 2, 3]` | `2` | 0→1→2 or 0→2 (both take 2 jumps) |
| `[5, 0, 0, 0, 0, 0]` | `1` | One big jump from start to end |

### Test Case Descriptions

1. **Happy path case:** Standard case with optimal 2-jump solution
2. **With zero obstacle:** Path works even with a 0 in the middle
3. **Minimum jumps case:** All 1s require hopping through entire array
4. **Edge case (single element):** Already at destination, 0 jumps needed
5. **Edge case (two elements):** Direct jump
6. **Multiple valid paths:** Different paths but same minimum jumps
7. **Single jump case:** Can reach end in one jump
