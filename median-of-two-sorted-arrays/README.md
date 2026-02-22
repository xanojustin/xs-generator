# Median of Two Sorted Arrays

## Problem

Given two sorted arrays `nums1` and `nums2` of size `m` and `n` respectively, return **the median** of the two sorted arrays.

The overall run time complexity should be `O(log(min(m,n)))`.

### Example 1:
- Input: nums1 = [1,3], nums2 = [2]
- Output: 2.0
- Explanation: merged array = [1,2,3] and median is 2.

### Example 2:
- Input: nums1 = [1,2], nums2 = [3,4]
- Output: 2.5
- Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_median_sorted_arrays.xs`):** Contains the binary search solution logic

## Function Signature

- **Input:**
  - `nums1` (int[]): First sorted array
  - `nums2` (int[]): Second sorted array
- **Output:** 
  - `median` (decimal): The median value of the combined sorted arrays, or null if both arrays are empty

## Algorithm

The solution uses binary search on the smaller array to find the correct partition:

1. Ensure we binary search on the smaller array for efficiency
2. Partition both arrays such that the left half contains half (or half+1) of all elements
3. Check if we found the correct partition: `max(left) <= min(right)` for both arrays
4. If partition is correct:
   - For odd total length: median is max of left partitions
   - For even total length: median is average of max(left) and min(right)
5. If partition is wrong: adjust binary search range

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| nums1 = [1, 3], nums2 = [2] | 2.0 |
| nums1 = [1, 2], nums2 = [3, 4] | 2.5 |
| nums1 = [], nums2 = [1] | 1.0 |
| nums1 = [2], nums2 = [] | 2.0 |
| nums1 = [], nums2 = [] | null |
| nums1 = [1, 3, 5], nums2 = [2, 4, 6] | 3.5 |
| nums1 = [1, 2, 3, 4, 5], nums2 = [6, 7, 8, 9, 10] | 5.5 |

## Complexity Analysis

- **Time Complexity:** O(log(min(m,n))) - We perform binary search on the smaller array
- **Space Complexity:** O(1) - Only using a constant amount of extra space
