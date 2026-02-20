# Factorial

## Problem
Calculate the factorial of a non-negative integer `n`.

The factorial of a non-negative integer `n` is the product of all positive integers less than or equal to `n`. It is denoted as `n!`.

**Mathematical definition:**
- `n! = n × (n-1) × (n-2) × ... × 2 × 1`
- `0! = 1` (by definition)
- Factorial is **not defined** for negative numbers

**Examples:**
- `5! = 5 × 4 × 3 × 2 × 1 = 120`
- `3! = 3 × 2 × 1 = 6`
- `0! = 1`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input
- **Function (`function/factorial.xs`):** Contains the iterative factorial calculation logic

## Function Signature
- **Input:** 
  - `n` (int): A non-negative integer to calculate factorial for
- **Output:** 
  - (int): The factorial of `n`, or an error if `n` is negative

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `5` | `120` | Standard case |
| `0` | `1` | Edge case: 0! = 1 by definition |
| `1` | `1` | Edge case: 1! = 1 |
| `10` | `3628800` | Larger number |
| `-3` | Error | Error case: factorial undefined for negatives |

## Implementation Notes

The solution uses an **iterative approach**:
1. Validates input is non-negative
2. Returns 1 immediately for base cases (0 or 1)
3. Uses a while loop to multiply numbers from 2 to n

This approach has:
- **Time Complexity:** O(n) - must multiply all numbers from 2 to n
- **Space Complexity:** O(1) - only uses a constant amount of extra space
