# Ugly Number II

## Problem

Write a program to find the **n-th ugly number**.

Ugly numbers are **positive numbers** whose prime factors only include `2`, `3`, and `5`.

### Examples

- **Example 1:**
  - Input: n = 10
  - Output: 12
  - Explanation: The first 10 ugly numbers are: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12

- **Example 2:**
  - Input: n = 1
  - Output: 1
  - Explanation: 1 is typically treated as an ugly number.

### Note
- `1` is typically treated as an ugly number
- The sequence of ugly numbers is: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32, 36, ...

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/ugly-number-ii.xs`):** Contains the solution logic using the three-pointer approach

## Algorithm

The solution uses a **three-pointer approach** with dynamic programming:

1. Maintain three pointers (`i2`, `i3`, `i5`) for each prime factor
2. At each step, calculate the next candidates:
   - `next2 = ugly[i2] * 2`
   - `next3 = ugly[i3] * 3`
   - `next5 = ugly[i5] * 5`
3. Pick the minimum of the three candidates
4. Add it to the ugly numbers list
5. Increment the pointer(s) that produced this minimum (handles duplicates like 6 = 2×3 = 3×2)

**Time Complexity:** O(n)  
**Space Complexity:** O(n)

## Function Signature

- **Input:**
  - `n` (int): The position of the ugly number to find (1-indexed)
  
- **Output:**
  - (int | null): The nth ugly number, or null if n <= 0

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 1 | 1 | First ugly number is always 1 |
| 10 | 12 | 10th ugly number in the sequence |
| 15 | 24 | 15th ugly number |
| 20 | 36 | 20th ugly number |
| 0 | null | Edge case: invalid input |
