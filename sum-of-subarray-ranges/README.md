# Sum of Subarray Ranges

## Problem

Given an integer array `nums`, return the **sum of all subarray ranges** of `nums`.

A **subarray** is a contiguous non-empty sequence of elements within an array.

The **range** of a subarray is the difference between the largest and smallest element in the subarray.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (nums=[1,2,3])
- **Function (`function/sum_of_subarray_ranges.xs`):** Contains the solution logic that calculates the sum of all subarray ranges

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers
  
- **Output:**
  - Returns (int): The sum of all subarray ranges (max - min) for every possible subarray

## Algorithm

1. Iterate over all possible subarrays using two nested loops
2. For each subarray:
   - Find the minimum value
   - Find the maximum value
   - Calculate the range (max - min)
   - Add to the running total
3. Return the total sum of all ranges

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| [1, 2, 3] | **4** | Used in run.xs - Subarrays: [1]=0, [2]=0, [3]=0, [1,2]=1, [2,3]=1, [1,2,3]=2. Sum = 0+0+0+1+1+2 = 4 |
| [1, 3] | **2** | Subarrays: [1]=0, [3]=0, [1,3]=2. Sum = 0+0+2 = 2 |
| [4, -2, -3, 4, 1] | **59** | Various subarray ranges sum to 59 |
| [] | **0** | Edge case: empty array |
| [5] | **0** | Edge case: single element (no range) |
| [2, 2, 2] | **0** | All elements equal, all ranges are 0 |

## Example Walkthrough

For nums=[1, 2, 3]:

| Subarray | Min | Max | Range (Max - Min) |
|----------|-----|-----|-------------------|
| [1] | 1 | 1 | 0 |
| [2] | 2 | 2 | 0 |
| [3] | 3 | 3 | 0 |
| [1, 2] | 1 | 2 | 1 |
| [2, 3] | 2 | 3 | 1 |
| [1, 2, 3] | 1 | 3 | 2 |

**Total Sum = 0 + 0 + 0 + 1 + 1 + 2 = 4**
