# Number of Steps to Reduce a Number to Zero

## Problem

Given an integer `num`, return the number of steps to reduce it to zero.

In one step, if the current number is even, you have to divide it by 2, otherwise, you subtract 1 from it.

### Examples

**Example 1:**
- Input: num = 14
- Output: 6
- Explanation: 
  - Step 1) 14 is even; divide by 2 and obtain 7.
  - Step 2) 7 is odd; subtract 1 and obtain 6.
  - Step 3) 6 is even; divide by 2 and obtain 3.
  - Step 4) 3 is odd; subtract 1 and obtain 2.
  - Step 5) 2 is even; divide by 2 and obtain 1.
  - Step 6) 1 is odd; subtract 1 and obtain 0.

**Example 2:**
- Input: num = 8
- Output: 4

**Example 3:**
- Input: num = 123
- Output: 12

### Constraints
- 0 ≤ num ≤ 10^6

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (num = 14)
- **Function (`function/count_steps.xs`):** Contains the solution logic with a while loop

## Function Signature

- **Input:** `num` (int) — The starting number to reduce to zero
- **Output:** `steps` (int) — The number of steps required to reduce num to zero

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 14 | 6 | 14→7→6→3→2→1→0 (6 steps) |
| 8 | 4 | 8→4→2→1→0 (4 steps) |
| 0 | 0 | Edge case: already zero, no steps needed |
| 1 | 1 | Single step: 1→0 |
| 123 | 12 | Larger number requiring multiple operations |

## Algorithm

The solution uses a simple iterative approach:
1. Initialize a step counter to 0
2. Initialize a current value to the input number
3. While current > 0:
   - If current is even, divide by 2
   - If current is odd, subtract 1
   - Increment step counter
4. Return the step counter

### Complexity Analysis
- **Time Complexity:** O(log n) — Each operation at least halves the number (when even) or makes it even (when odd followed by halving)
- **Space Complexity:** O(1) — Only uses two variables regardless of input size
