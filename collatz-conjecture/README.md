# Collatz Conjecture

## Problem

The Collatz Conjecture (also known as the 3n+1 problem or the Syracuse problem) is a famous unsolved mathematical problem. Given a positive integer `n`, repeatedly apply the following rules until `n` becomes 1:

- If `n` is **even**, divide it by 2
- If `n` is **odd**, multiply it by 3 and add 1

The conjecture states that no matter what positive integer you start with, you will always eventually reach 1.

**Task:** Given a positive integer `n`, return the number of steps required to reach 1.

### Example

Starting with n = 12:
- 12 is even → 6 (step 1)
- 6 is even → 3 (step 2)
- 3 is odd → 10 (step 3)
- 10 is even → 5 (step 4)
- 5 is odd → 16 (step 5)
- 16 is even → 8 (step 6)
- 8 is even → 4 (step 7)
- 4 is even → 2 (step 8)
- 2 is even → 1 (step 9)

Result: **9 steps**

## Structure

- **Run Job (`run.xs`):** Entry point that calls the test function
- **Function (`function/collatz-conjecture.xs`):** Contains the solution logic that calculates steps to reach 1
- **Test Function (`function/collatz-test.xs`):** Runs multiple test cases and returns all results

## Function Signature

### collatz-conjecture
- **Input:** 
  - `n` (int): A positive integer (n ≥ 1)
- **Output:** 
  - (int): The number of steps required to reach 1
- **Error:** Throws `inputerror` if n is not positive

### collatz-test
- **Input:** None
- **Output:** Object containing all test results
- **Logs:** Debug output for each test case

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 1 | 0 | Already at 1, no steps needed |
| 2 | 1 | 2 → 1 (1 step) |
| 3 | 7 | 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 (7 steps) |
| 6 | 8 | 6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 (8 steps) |
| 7 | 16 | Longer sequence with 16 steps |
| 19 | 20 | Even longer sequence with 20 steps |
| 0 | error | Invalid input (must be positive) |

## Notes

- This is an unsolved problem in mathematics - it's not proven that all starting numbers eventually reach 1, but it has been verified for all numbers up to very large values
- The sequence can go up and down before eventually reaching 1
- Some numbers produce very long sequences (try n = 27!)
