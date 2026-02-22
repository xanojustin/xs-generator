# Sliding Window Maximum

## Problem

Given an array of integers `nums` and a sliding window of size `k` that moves from the left to the right of the array, return an array containing the maximum value in each window position.

The sliding window moves one position to the right at a time. For each window position, you need to find the maximum element within that window.

### Example
```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]

Window positions:
[1  3  -1] -3  5  3  6  7  → max = 3
 1 [3  -1  -3] 5  3  6  7  → max = 3
 1  3 [-1  -3  5] 3  6  7  → max = 5
 1  3  -1 [-3  5  3] 6  7  → max = 5
 1  3  -1  -3 [5  3  6] 7  → max = 6
 1  3  -1  -3  5 [3  6  7] → max = 7
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with multiple test cases and logs results
- **Function (`function/sliding_window_maximum.xs`):** Contains the deque-based solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers
  - `k` (int): Window size (must be at least 1)
- **Output:** 
  - `int[]`: Array containing the maximum value for each window position

## Algorithm

This solution uses a **deque (double-ended queue)** to achieve O(n) time complexity:

1. The deque stores indices of elements in decreasing order of their values
2. For each new element, remove all smaller elements from the back of the deque
3. Remove indices that fall outside the current window from the front
4. The front of the deque always contains the maximum of the current window

**Time Complexity:** O(n) — each element is added and removed from the deque at most once
**Space Complexity:** O(k) — the deque stores at most k indices

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums=[1,3,-1,-3,5,3,6,7]`, `k=3` | `[3,3,5,5,6,7]` |
| `nums=[5,4,3,2,1]`, `k=1` | `[5,4,3,2,1]` |
| `nums=[1,2,3,4,5]`, `k=5` | `[5]` |
| `nums=[]`, `k=3` | `[]` (empty array edge case) |
| `nums=[1,2]`, `k=5` | `[]` (window larger than array) |
| `nums=[5,5,5,5,5]`, `k=2` | `[5,5,5,5]` (all same elements) |
| `nums=[-7,-8,-7,-5,-4,-3,-2]`, `k=3` | `[-7,-5,-4,-3,-2]` (negative numbers) |
