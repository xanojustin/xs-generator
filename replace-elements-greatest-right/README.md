# Replace Elements with Greatest Element on Right Side

## Problem
Given an array `arr`, replace every element in that array with the greatest element among the elements to its right, and replace the last element with `-1`.

After doing so, return the modified array.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/replace_greatest.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `arr` (int[]): Array of integers to process
- **Output:**
  - `result` (int[]): Modified array where each element is replaced by the greatest element to its right (last element is -1)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[17, 18, 5, 4, 6, 1]` | `[18, 6, 6, 6, 1, -1]` |
| `[400]` | `[-1]` |
| `[1, 2, 3, 4, 5]` | `[5, 5, 5, 5, -1]` |
| `[5, 4, 3, 2, 1]` | `[4, 3, 2, 1, -1]` |

### Explanation of Test Cases

1. **Basic case:** `[17, 18, 5, 4, 6, 1]`
   - Index 0: greatest to right is 18
   - Index 1: greatest to right is 6
   - Index 2: greatest to right is 6
   - Index 3: greatest to right is 6
   - Index 4: greatest to right is 1
   - Index 5: last element becomes -1
   - Result: `[18, 6, 6, 6, 1, -1]`

2. **Single element:** `[400]`
   - Only element becomes -1
   - Result: `[-1]`

3. **Increasing array:** `[1, 2, 3, 4, 5]`
   - Each element gets replaced by the last element (5), except last becomes -1
   - Result: `[5, 5, 5, 5, -1]`

4. **Decreasing array:** `[5, 4, 3, 2, 1]`
   - Each element gets replaced by its immediate right neighbor
   - Result: `[4, 3, 2, 1, -1]`

## Algorithm
The optimal solution works backwards from the end of the array:
1. Initialize `max_from_right = -1` (this will be the new last element)
2. Iterate from right to left
3. For each element, store the current `max_from_right` in the result
4. Update `max_from_right` to be the maximum of itself and the current element
5. This gives O(n) time complexity with O(1) extra space (excluding output array)
