# Max Consecutive Ones III

## Problem
Given a binary array `nums` and an integer `k`, return the maximum number of consecutive 1's in the array if you can flip at most `k` 0's.

This is a classic sliding window problem where we want to find the longest subarray that contains at most `k` zeros.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_consecutive_ones_iii.xs`):** Contains the solution logic using sliding window technique

## Function Signature
- **Input:**
  - `nums` (int[]): Binary array containing only 0s and 1s
  - `k` (int): Maximum number of 0s that can be flipped to 1s (k ≥ 0)
- **Output:** (int) Maximum length of consecutive 1s achievable by flipping at most k 0s

## Algorithm
Uses the sliding window (two pointers) technique:
- `left` pointer marks the start of the window
- Expand the window by iterating through `nums`
- Count zeros in the current window
- If zeros exceed `k`, shrink window from the left until zeros ≤ k
- Track the maximum window size throughout

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0] | 2 | 6 |
| [0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1] | 3 | 10 |
| [1, 1, 1, 1] | 0 | 4 |
| [0, 0, 0] | 0 | 0 |
| [0, 0, 0] | 3 | 3 |
| [] | 2 | 0 |

### Explanation of Test Cases:
1. **Basic case:** Flipping two 0s allows us to get 6 consecutive 1s (positions 3-8 after flips)
2. **Complex case:** With k=3, we can achieve 10 consecutive 1s
3. **All 1s, no flips needed:** Returns the full array length
4. **All 0s, no flips allowed:** Returns 0
5. **All 0s, can flip all:** Returns full array length
6. **Empty array:** Edge case returns 0
