# Sum of Squares

## Problem
Calculate the sum of squares of the first n natural numbers.

The sum of squares formula is:
```
1² + 2² + 3² + ... + n² = n(n+1)(2n+1)/6
```

For example:
- Sum of squares up to 3: 1² + 2² + 3² = 1 + 4 + 9 = 14
- Sum of squares up to 5: 1² + 2² + 3² + 4² + 5² = 1 + 4 + 9 + 16 + 25 = 55

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_of_squares.xs`):** Contains the solution logic using the mathematical formula

## Function Signature
- **Input:** 
  - `n` (int): The upper limit (inclusive) for the sum of squares calculation. Must be non-negative.
- **Output:** 
  - (int): The sum of squares from 1² to n²

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 0 | 0 | Edge case: empty sum |
| 1 | 1 | 1² = 1 |
| 3 | 14 | 1² + 2² + 3² = 1 + 4 + 9 = 14 |
| 5 | 55 | 1² + 2² + 3² + 4² + 5² = 55 |
| 10 | 385 | 1² + 2² + ... + 10² = 385 |

## Implementation Notes
This solution uses the closed-form mathematical formula:
```
Sum = n(n+1)(2n+1)/6
```

This approach is O(1) time complexity compared to O(n) for an iterative solution, making it efficient even for very large values of n.
