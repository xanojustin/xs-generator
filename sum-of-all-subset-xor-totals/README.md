# Sum of All Subset XOR Totals

## Problem

The **XOR total** of an array is defined as the bitwise XOR of all its elements.

Given an array `nums`, return the sum of the XOR totals for every subset of `nums`.

A subset is any combination of elements from the array (including the empty subset). The empty subset has a XOR total of 0.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/calculate_subset_xor_totals.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): An array of integers

- **Output:**
  - `int`: The sum of XOR totals of all possible subsets

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| [1, 3] | 6 |
| [5, 1, 6] | 28 |
| [3, 4, 5, 6, 7, 8] | 480 |
| [] | 0 |
| [10] | 10 |

### Explanation of Test Cases:

1. **[1, 3]:**
   - Subsets and their XOR totals: [] = 0, [1] = 1, [3] = 3, [1,3] = 1 XOR 3 = 2
   - Sum: 0 + 1 + 3 + 2 = 6

2. **[5, 1, 6]:**
   - All subsets: [], [5], [1], [6], [5,1], [5,6], [1,6], [5,1,6]
   - XOR totals: 0, 5, 1, 6, 4, 3, 7, 2
   - Sum: 0 + 5 + 1 + 6 + 4 + 3 + 7 + 2 = 28

3. **Empty array:** Only the empty subset exists with XOR total of 0

## Algorithm

The solution uses an iterative approach to generate all subset XOR values:

1. Start with `[0]` representing the empty subset's XOR total
2. For each number in the array:
   - For each existing subset XOR value, create a new subset by XORing with the current number
   - Add these new XOR values to the collection
3. Sum all collected XOR values using the `sum` filter

This approach efficiently builds up all possible subset XOR values without explicitly generating all subsets.
