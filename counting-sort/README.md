# Counting Sort

## Problem
Implement the **Counting Sort** algorithm to sort an array of non-negative integers.

Counting Sort is a non-comparison-based sorting algorithm that works by:
1. Finding the maximum value in the input array
2. Creating a count array to store the frequency of each unique element
3. Reconstructing the sorted array based on the counts

**Key Properties:**
- Time Complexity: O(n + k) where n is array length and k is the range of values
- Space Complexity: O(k) where k is the maximum value
- Stable and works well when the range of values (k) is not significantly larger than the number of elements (n)
- Only works with non-negative integers

## Structure
- **Run Job (`run.xs`):** Calls the counting sort function with a test array
- **Function (`function/counting-sort.xs`):** Implements the counting sort algorithm

## Function Signature
- **Input:** 
  - `arr` (int[]): Array of non-negative integers to sort
- **Output:** 
  - Sorted array (int[]) in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[4, 2, 2, 8, 3, 3, 1]` | `[1, 2, 2, 3, 3, 4, 8]` |
| `[5, 3, 8, 4, 2]` | `[2, 3, 4, 5, 8]` |
| `[]` | `[]` |
| `[1]` | `[1]` |
| `[3, 3, 3]` | `[3, 3, 3]` |
| `[0, 5, 0, 3, 2]` | `[0, 0, 2, 3, 5]` |
