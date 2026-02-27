# Kth Smallest Element in a Sorted Matrix

## Problem

Given an `n x n` matrix where each row and column is sorted in ascending order, find the **kth smallest** element in the matrix.

Note that it is the kth smallest element in the sorted order, not the kth distinct element.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kth_smallest_sorted_matrix.xs`):** Contains the solution logic using binary search on value range

## Function Signature

- **Input:**
  - `matrix` (object): An n x n matrix object with a `rows` array, where each row has a `values` array of integers
  - `k` (int): The position of the element to find (1-based index)
  
- **Output:**
  - `result` (int): The kth smallest element in the matrix

## Algorithm

The solution uses **binary search on the value range** for O(n log(max-min)) time complexity:

1. Find the minimum value (top-left corner) and maximum value (bottom-right corner)
2. Binary search between these bounds
3. For each middle value, count how many elements are ≤ mid using a two-pointer technique starting from the bottom-left
4. Adjust binary search bounds based on the count

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `matrix=[[1,5,9],[10,11,13],[12,13,15]], k=8` | `13` |
| `matrix=[[5]], k=1` | `5` |
| `matrix=[[1,2],[3,4]], k=3` | `3` |
| `matrix=[[1,2,3],[2,3,4],[3,4,5]], k=5` | `3` |
| `matrix=[[1,10,100],[1000,10000,100000],[1000000,10000000,100000000]], k=5` | `10000` |

### Test Case Explanations

1. **Basic 3x3 matrix:** The sorted order is [1,5,9,10,11,12,13,**13**,15], so the 8th element is 13
2. **Single element (edge case):** Matrix with just one element, k=1 returns that element
3. **2x2 matrix:** The sorted order is [1,2,**3**,4], so the 3rd element is 3
4. **Matrix with duplicates:** The sorted order is [1,2,2,3,**3**,3,4,4,5], so the 5th element is 3
5. **Large range values:** Tests that the algorithm handles large value ranges correctly

## Constraints

- n == matrix.rows.length
- n == matrix.rows[i].values.length
- 1 ≤ n ≤ 300
- -10^9 ≤ matrix.rows[i].values[j] ≤ 10^9
- All rows and columns are sorted in non-decreasing order
- 1 ≤ k ≤ n²
