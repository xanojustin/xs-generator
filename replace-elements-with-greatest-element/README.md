# Replace Elements with Greatest Element on Right Side

## Problem
Given an array `arr`, replace every element in that array with the greatest element among the elements to its right, and replace the last element with `-1`.

After doing so, return the modified array.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/replace_elements.xs`):** Contains the solution logic

## Function Signature
- **Input:** `arr` - An array of integers (`int[]`)
- **Output:** An array of integers where each element at index `i` is replaced by the maximum element in `arr[i+1:]` (elements to the right), with the last element being `-1`

## Algorithm Explanation
The solution traverses the array from right to left, keeping track of the maximum element seen so far:
1. Initialize `max_from_right = -1` (this will be the value for the last element)
2. Traverse from the end of the array to the beginning
3. For each element, store the current `max_from_right` as the result, then update `max_from_right` if the current element is greater
4. This approach is O(n) time and O(n) space for the result

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[17, 18, 5, 4, 6, 1]` | `[18, 6, 6, 6, 1, -1]` | 17→max(18,5,4,6,1)=18, 18→max(5,4,6,1)=6, etc. |
| `[400]` | `[-1]` | Single element, replaced with -1 |
| `[]` | `[]` | Empty array returns empty array |
| `[1, 2, 3, 4, 5]` | `[5, 5, 5, 5, -1]` | Strictly increasing array |
| `[5, 4, 3, 2, 1]` | `[4, 3, 2, 1, -1]` | Strictly decreasing array |

## Example Walkthrough

For input `[17, 18, 5, 4, 6, 1]`:

| Index | Element | max_from_right (before) | Result at index | max_from_right (after) |
|-------|---------|------------------------|-----------------|------------------------|
| 5 | 1 | -1 | -1 | max(1, -1) = 1 |
| 4 | 6 | 1 | 1 | max(6, 1) = 6 |
| 3 | 4 | 6 | 6 | max(4, 6) = 6 |
| 2 | 5 | 6 | 6 | max(5, 6) = 6 |
| 1 | 18 | 6 | 6 | max(18, 6) = 18 |
| 0 | 17 | 18 | 18 | max(17, 18) = 18 |

Result: `[18, 6, 6, 6, 1, -1]`

## Complexity Analysis
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(n) - for the output array (not counting the input)
