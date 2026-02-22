# Find Peak Element

## Problem
A peak element is an element that is strictly greater than its neighbors.

Given an integer array `nums`, find a peak element and return its index. If the array contains multiple peaks, return the index to any of the peaks.

You may imagine that `nums[-1] = nums[n] = -∞`. In other words, an element is always considered to be strictly greater than a neighbor that is outside the array.

You must write an algorithm that runs in O(log n) time.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_peak_element.xs`):** Contains the solution logic using binary search

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers
- **Output:** 
  - `int`: Index of a peak element, or -1 if the array is empty

## Algorithm
This solution uses a modified binary search approach:
1. Handle edge cases (empty array, single element)
2. Use binary search to find a peak:
   - Compare middle element with its neighbors
   - If mid is a peak (greater than both neighbors), return it
   - If left neighbor is greater, search left half
   - If right neighbor is greater, search right half
3. This achieves O(log n) time complexity

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3, 1]` | `2` | 3 is a peak (greater than 2 and 1) |
| `[1, 2, 1, 3, 5, 6, 4]` | `1` or `5` | 2 at index 1 OR 6 at index 5 are both peaks |
| `[]` | `-1` | Empty array has no peak |
| `[5]` | `0` | Single element is a peak |
| `[1, 2]` | `1` | 2 at index 1 is a peak (only checks left neighbor) |
| `[2, 1]` | `0` | 2 at index 0 is a peak (only checks right neighbor) |
| `[1, 2, 3, 4, 5]` | `4` | Last element is peak (ascending array) |
| `[5, 4, 3, 2, 1]` | `0` | First element is peak (descending array) |

## Complexity Analysis
- **Time Complexity:** O(log n) — Binary search reduces the search space by half each iteration
- **Space Complexity:** O(1) — Only uses a constant amount of extra space

## Notes
- The problem guarantees that a peak always exists for non-empty arrays
- For arrays with multiple peaks, any peak index is a valid answer
- The binary search approach is key to achieving logarithmic time complexity
