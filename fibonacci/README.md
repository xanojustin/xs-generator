# Fibonacci Sequence Generator

## Problem
Generate the first n Fibonacci numbers.

The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones:
- F(0) = 0
- F(1) = 1
- F(n) = F(n-1) + F(n-2) for n > 1

Example sequence: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input n=10
- **Function (`function/fibonacci.xs`):** Contains the solution logic that generates the Fibonacci sequence

## Function Signature
- **Input:** 
  - `n` (int): The number of Fibonacci numbers to generate
- **Output:** 
  - `int[]`: Array of integers representing the first n Fibonacci numbers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n = 1 | `[0]` |
| n = 2 | `[0, 1]` |
| n = 5 | `[0, 1, 1, 2, 3]` |
| n = 10 | `[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]` |
| n = 0 | `[]` (edge case: empty result) |
| n = -5 | `[]` (edge case: negative input) |

## Key Logic Points
1. The sequence starts with 0 and 1 as the first two numbers
2. Each subsequent number is the sum of the previous two
3. Handle edge cases where n < 1 by returning an empty array
4. The algorithm uses an iterative approach with O(n) time complexity
