# N-th Tribonacci Number

## Problem

The Tribonacci sequence Tn is defined as follows:

- T(0) = 0
- T(1) = 1
- T(2) = 1
- T(n+3) = T(n) + T(n+1) + T(n+2) for n >= 0

Given `n`, return the value of T(n).

The Tribonacci sequence begins:
```
0, 1, 1, 2, 4, 7, 13, 24, 44, 81, 149, 274, 504, 927, 1705, 3136, 5768, 10609, 19513, 35890, 66012, 121415, 223317, 410744, 755476, 1389537...
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/tribonacci.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `n` (int): The position in the Tribonacci sequence (0-indexed)
- **Output:** 
  - (int): The n-th Tribonacci number

## Algorithm

The solution uses an iterative dynamic programming approach with O(n) time complexity and O(1) space complexity:

1. Handle base cases (n = 0, 1, 2) with direct returns
2. Use three variables to track the previous three Tribonacci numbers
3. Iterate from 3 to n, computing each new value as the sum of the previous three
4. Update the variables for the next iteration

This is more efficient than the recursive approach which has exponential time complexity.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 0 | 0 | Base case T(0) = 0 |
| 1 | 1 | Base case T(1) = 1 |
| 2 | 1 | Base case T(2) = 1 |
| 4 | 4 | T(4) = T(1) + T(2) + T(3) = 1 + 1 + 2 = 4 |
| 10 | 149 | T(10) = 81 + 44 + 24 = 149 |
| 25 | 1389537 | Large input to test efficiency |

## Complexity Analysis

- **Time Complexity:** O(n) - single pass through the sequence
- **Space Complexity:** O(1) - only three variables needed regardless of input size

## Related Problems

- Fibonacci Number (2-term recurrence)
- Climbing Stairs (similar DP pattern)
