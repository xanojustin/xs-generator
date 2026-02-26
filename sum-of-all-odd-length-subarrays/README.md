# Sum of All Odd Length Subarrays

## Problem

Given an array of positive integers, return the sum of all possible **odd-length subarrays**.

A **subarray** is a contiguous subsequence of the array.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with multiple test cases
- **Function (`function/sum_odd_length_subarrays.xs`):** Contains the solution logic

## Function Signature

- **Input:** `int[] arr` - An array of positive integers
- **Output:** `int` - The sum of all odd-length subarrays

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 4, 2, 5, 3]` | `58` |
| `[1, 2]` | `3` |
| `[10, 11, 12]` | `66` |
| `[5]` | `5` |
| `[1, 2, 3, 4, 5, 6, 7]` | `112` |

### Explanation of Test Cases

**Case 1:** `[1, 4, 2, 5, 3]` → `58`
- Odd-length subarrays: [1], [4], [2], [5], [3], [1,4,2], [4,2,5], [2,5,3], [1,4,2,5,3]
- Sums: 1 + 4 + 2 + 5 + 3 + 7 + 11 + 9 + 15 = **58**

**Case 2:** `[1, 2]` → `3`
- Only single elements are odd-length: [1], [2]
- Sums: 1 + 2 = **3**

**Case 3:** `[10, 11, 12]` → `66`
- Odd-length subarrays: [10], [11], [12], [10,11,12]
- Sums: 10 + 11 + 12 + 33 = **66**

**Case 4:** `[5]` → `5`
- Single element array: [5]
- Sum: **5**

**Case 5:** `[1, 2, 3, 4, 5, 6, 7]` → `112`
- All odd-length subarrays from length 1, 3, 5, 7
