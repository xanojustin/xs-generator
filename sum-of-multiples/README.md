# Sum of Multiples

## Problem
Given a number `limit`, find the sum of all the unique multiples of 3 or 5 below `limit`.

For example, if we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6, and 9. The sum of these multiples is 23.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_of_multiples.xs`):** Contains the solution logic

## Function Signature
- **Input:** `limit` (int) - The upper bound (exclusive). Sum all multiples of 3 or 5 that are strictly less than this number.
- **Output:** `sum` (int) - The sum of all unique multiples of 3 or 5 below the limit

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 10 | 23 | 3 + 5 + 6 + 9 = 23 |
| 1000 | 233168 | Sum of all multiples of 3 or 5 below 1000 (classic Project Euler #1) |
| 1 | 0 | No multiples below 1 |
| 3 | 0 | Only 3 is a multiple, but we need numbers *below* 3 |
| 4 | 3 | Only 3 is a multiple below 4 |
| 6 | 8 | 3 + 5 = 8 |

## Example Usage

The run job calls the function with:
```
limit: 10
```

Which returns: `23`

## Learning Points
- Uses a simple loop to iterate through numbers
- Demonstrates modulo arithmetic (`%` operator)
- Shows conditional logic with `if` statements
- Uses `var.update` to modify loop counter and accumulator
