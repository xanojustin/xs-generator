# Sliding Window Minimum

## Problem

Given an array of integers `nums` and a positive integer `k`, find the minimum value in every contiguous subarray (window) of size `k`.

For example, with `nums = [1, 3, -1, -3, 5, 3, 6, 7]` and `k = 3`:
- Window 1: `[1, 3, -1]` → minimum is `-1`
- Window 2: `[3, -1, -3]` → minimum is `-3`
- Window 3: `[-1, -3, 5]` → minimum is `-3`
- Window 4: `[-3, 5, 3]` → minimum is `-3`
- Window 5: `[5, 3, 6]` → minimum is `3`
- Window 6: `[3, 6, 7]` → minimum is `3`

Result: `[-1, -3, -3, -3, 3, 3]`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sliding_window_minimum.xs`):** Contains the solution logic using a deque-based O(n) algorithm

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers to process
  - `k` (int): Window size (must be ≥ 1 and ≤ length of nums)
- **Output:**
  - `int[]`: Array of minimum values, one for each window position

## Algorithm

The solution uses a **monotonic deque** (double-ended queue) to achieve O(n) time complexity:

1. The deque stores indices of elements in increasing order of their values
2. For each new element, remove from the back all elements ≥ current element (they can never be minimum)
3. Remove from the front if the index is outside the current window
4. The front of the deque always holds the minimum for the current window

**Time Complexity:** O(n) — each element is added and removed from deque at most once  
**Space Complexity:** O(k) — deque holds at most k indices

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [1, 3, -1, -3, 5, 3, 6, 7], k: 3` | `[-1, -3, -3, -3, 3, 3]` |
| `nums: [5, 4, 3, 2, 1], k: 2` | `[4, 3, 2, 1]` |
| `nums: [1], k: 1` | `[1]` |
| `nums: [1, -1], k: 1` | `[1, -1]` |
| `nums: [7, 2, 4], k: 2` | `[2, 2]` |

### Edge Cases Covered

- **Single element array:** Window size equals array length
- **Window size of 1:** Each element is its own minimum
- **Strictly decreasing array:** Each new element becomes the new minimum
- **Negative numbers:** Handled correctly in comparisons
