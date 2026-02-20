# Fibonacci

## Problem
Calculate the nth Fibonacci number, where each number is the sum of the two preceding ones.

The Fibonacci sequence starts:
- F(0) = 0
- F(1) = 1
- F(n) = F(n-1) + F(n-2) for n > 1

So the sequence goes: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144...

## Structure
- **Run Job (`run.xs`):** Calls the test runner function
- **Function (`function/fibonacci.xs`):** Contains the Fibonacci calculation logic
- **Function (`function/fibonacci_tests.xs`):** Test runner that validates multiple cases

## Function Signature

### fibonacci (main solution)
- **Input:** 
  - `n` (int) - The position in the Fibonacci sequence (0-indexed)
- **Output:** 
  - (int) - The nth Fibonacci number

### fibonacci_tests (test runner)
- **Input:** None
- **Output:** 
  - (object) - Test results with input, expected, actual, and pass/fail status for each test case

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 0 | 0 (edge case) |
| 1 | 1 (edge case) |
| 5 | 5 (basic case) |
| 10 | 55 (larger case) |
| 20 | 6765 (boundary case) |

## Implementation Details

The solution uses an **iterative approach** for O(n) time complexity and O(1) space complexity:

1. Handle edge cases (n <= 0 returns 0, n == 1 returns 1)
2. Use two variables to track previous and current values
3. Iterate from 2 to n, calculating each Fibonacci number
4. Return the final result

This is more efficient than the recursive approach which has exponential time complexity.
