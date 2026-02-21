# Container With Most Water

## Problem

You are given an integer array `heights` of length `n`. There are `n` vertical lines drawn such that the two endpoints of the `i`th line are `(i, 0)` and `(i, heights[i])`.

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

**Note:** You may not slant the container.

### Example
```
Input: heights = [1, 8, 6, 2, 5, 4, 8, 3, 7]
Output: 49

The lines at index 1 (height 8) and index 8 (height 7) form the container.
Width = 8 - 1 = 7
Height = min(8, 7) = 7
Area = 7 * 7 = 49
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/container_with_most_water.xs`):** Contains the solution logic using two-pointer approach

## Function Signature

- **Input:**
  - `heights` (int[]): Array of non-negative integers where each element represents the height of a vertical line at that x-coordinate
  
- **Output:**
  - `max_area` (int): The maximum area of water that can be contained between any two lines

## Algorithm

The solution uses a **two-pointer approach** with O(n) time complexity:

1. Initialize two pointers: `left` at index 0 and `right` at the last index
2. Calculate the area between the two lines: `area = min(height[left], height[right]) * (right - left)`
3. Update `max_area` if current area is larger
4. Move the pointer with the **smaller height** inward (moving the taller pointer cannot increase area since the height is limited by the shorter line)
5. Repeat until pointers meet

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 8, 6, 2, 5, 4, 8, 3, 7]` | `49` | Lines at index 1 (height 8) and 8 (height 7): min(8,7) × (8-1) = 7×7 = 49 |
| `[1, 1]` | `1` | Only two lines: min(1,1) × (1-0) = 1×1 = 1 |
| `[4, 3, 2, 1, 4]` | `16` | Lines at index 0 and 4 (both height 4): min(4,4) × (4-0) = 4×4 = 16 |
| `[1, 2, 4, 3]` | `4` | Lines at index 1 (height 2) and 2 (height 4): min(2,4) × (2-1) = 2×1 = 2, but index 0 and 3: min(1,3) × 3 = 3. Best is index 1 and 3: min(2,3) × 2 = 4 |
| `[]` | `0` | Empty array, no container possible |
| `[5]` | `0` | Single element, need at least two lines |
| `[0, 2]` | `0` | One line has zero height, area is zero |
