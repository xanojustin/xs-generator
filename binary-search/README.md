# Binary Search

## Problem
Given a **sorted array of integers** in ascending order and a **target value**, return the index of the target if it exists in the array, or `-1` if it does not exist.

Binary search works by repeatedly dividing the search interval in half. Compare the target value to the middle element of the array:
- If the target equals the middle element, return the middle index
- If the target is less than the middle element, search the left half
- If the target is greater than the middle element, search the right half

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/binary_search.xs`):** Contains the binary search algorithm implementation

## Function Signature
- **Input:**
  - `nums` (int[]): Sorted array of integers in ascending order
  - `target` (int): Target value to search for
- **Output:**
  - (int): Index of the target value if found, `-1` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [1, 3, 5, 7, 9, 11, 13, 15, 17, 19], target: 13` | `6` (index of 13) |
| `nums: [2, 4, 6, 8, 10], target: 2` | `0` (first element) |
| `nums: [2, 4, 6, 8, 10], target: 10` | `4` (last element) |
| `nums: [1, 2, 3], target: 5` | `-1` (not found) |
| `nums: [], target: 5` | `-1` (empty array edge case) |
| `nums: [42], target: 42` | `0` (single element) |

## Algorithm
This solution uses an **iterative binary search** approach:
1. Initialize two pointers: `left` at the start (0) and `right` at the end (length - 1)
2. While `left` <= `right`:
   - Calculate `mid` = `left` + (`right` - `left`) / 2 (avoids potential overflow)
   - If `nums[mid]` equals target, return `mid`
   - If `nums[mid]` < target, move `left` to `mid` + 1 (search right half)
   - If `nums[mid]` > target, move `right` to `mid` - 1 (search left half)
3. If the loop ends without finding the target, return `-1`

**Time Complexity:** O(log n) — the search space is halved each iteration  
**Space Complexity:** O(1) — only uses a constant amount of extra space
