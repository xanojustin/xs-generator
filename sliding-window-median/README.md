# Sliding Window Median

## Problem

Given an integer array `nums` and an integer `k`, return the median of each sliding window of size `k` as it moves from left to right across the array.

The window moves one position at a time. For each window position:
- If `k` is **odd**: the median is the middle element after sorting the window
- If `k` is **even**: the median is the average of the two middle elements after sorting

### Example

```
Input: nums = [1, 3, -1, -3, 5, 3, 6, 7], k = 3
Output: [1, -1, -1, 3, 5, 6]

Window positions:
[1, 3, -1]  -> sorted: [-1, 1, 3]  -> median: 1
 [3, -1, -3] -> sorted: [-3, -1, 3] -> median: -1
  [-1, -3, 5] -> sorted: [-3, -1, 5] -> median: -1
   [-3, 5, 3]  -> sorted: [-3, 3, 5]  -> median: 3
    [5, 3, 6]   -> sorted: [3, 5, 6]   -> median: 5
     [3, 6, 7]   -> sorted: [3, 6, 7]   -> median: 6
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sliding_window_median.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): The array of integers to process
  - `k` (int): The size of the sliding window
  
- **Output:** 
  - `int[]` or `decimal[]`: Array containing the median of each window position

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums=[1,3,-1,-3,5,3,6,7]`, `k=3` | `[1,-1,-1,3,5,6]` |
| `nums=[1,2,3,4,2,3,1,4,2]`, `k=4` | `[2,2.5,2.5,2.5,3,2.5]` |
| `nums=[5,2,9,1]`, `k=4` | `[3.5]` |
| `nums=[7,3,9,1,5]`, `k=1` | `[7,3,9,1,5]` |
| `nums=[]`, `k=3` | `[]` |
| `nums=[1,2,3]`, `k=5` | `[]` |

### Test Case Descriptions

1. **Basic odd window:** Standard case with k=3 (odd)
2. **Even window:** Tests averaging two middle elements (k=4)
3. **Full array window:** Window spans entire array
4. **Single element:** Each window has only one element
5. **Empty array:** Edge case - empty input
6. **Window too large:** k exceeds array length
