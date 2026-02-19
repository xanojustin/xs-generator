# Fibonacci

## Problem

Generate the first n Fibonacci numbers.

The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones, starting from 0 and 1:
- F(0) = 0
- F(1) = 1
- F(n) = F(n-1) + F(n-2) for n > 1

For example, the first 10 Fibonacci numbers are: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34

This classic coding exercise tests understanding of:
- Sequence generation
- Iterative algorithms
- Array manipulation

## Function Signature

- **Input:** `n` (int) - The number of Fibonacci numbers to generate (must be >= 1, max 50)
- **Output:** `int[]` - An array of integers containing the first n Fibonacci numbers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 1 | `[0]` |
| 2 | `[0, 1]` |
| 5 | `[0, 1, 1, 2, 3]` |
| 10 | `[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]` |
| 0 | Error (validation: min:1) |

### Edge Cases Explained

1. **n = 1**: Single element array with just `[0]` - tests the base case
2. **n = 2**: Two element array `[0, 1]` - tests the second base case
3. **n = 5**: Tests the recurrence relation (1+1=2, 1+2=3, etc.)
4. **n = 0**: Should fail validation since n must be >= 1
5. **Large n (50)**: Tests performance with maximum allowed input (F(49) = 7778742049)
