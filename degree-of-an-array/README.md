# Degree of an Array

## Problem

Given a non-empty array of non-negative integers `nums`, the **degree** of this array is defined as the maximum frequency of any one of its elements.

Your task is to find the smallest possible length of a (contiguous) subarray of `nums` that has the same degree as `nums`.

### Example 1:
- **Input:** nums = [1, 2, 2, 3, 1]
- **Output:** 2
- **Explanation:** The input array has a degree of 2 because both elements 1 and 2 appear twice. The shortest subarray with degree 2 is [2, 2] at indices 1-2, which has length 2.

### Example 2:
- **Input:** nums = [1, 2, 2, 3, 1, 4, 2]
- **Output:** 6
- **Explanation:** The degree is 3 because element 2 appears three times. The shortest subarray containing all three 2s is [2, 2, 3, 1, 4, 2] at indices 1-6, which has length 6.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/degree_of_array.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of non-negative integers
  
- **Output:**
  - (int): The length of the smallest subarray with the same degree as the input array

## Approach

1. **First Pass - Build Statistics:**
   - Count frequency of each element
   - Track first occurrence index of each element
   - Track last occurrence index of each element
   - Determine the overall degree of the array (maximum frequency)

2. **Second Pass - Find Minimum Length:**
   - For each element with frequency equal to the array degree
   - Calculate the subarray length: `last_index - first_index + 1`
   - Return the minimum such length

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| [1, 2, 2, 3, 1] | 2 | Degree is 2 (1 and 2 appear twice), shortest subarray is [2, 2] |
| [1, 2, 2, 3, 1, 4, 2] | 6 | Degree is 3 (2 appears three times), shortest subarray spans all three 2s |
| [1, 2, 3, 4, 5] | 1 | Degree is 1 (all unique), any single element works |
| [1, 1, 1, 1] | 4 | Degree is 4, entire array is the subarray |
| [] | 0 | Empty array edge case |
| [5] | 1 | Single element array |
| [1, 1, 2, 2, 2, 1] | 3 | Degree is 3 (2 appears three times), subarray [2, 2, 2] |

## Complexity Analysis

- **Time Complexity:** O(n) - Two passes through the array
- **Space Complexity:** O(k) - Where k is the number of unique elements (stored in hash maps)
