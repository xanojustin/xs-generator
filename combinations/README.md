# Combinations

## Problem

Given two integers `n` and `k`, return all possible combinations of `k` numbers chosen from the range `[1, n]`.

You may return the answer in any order.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (n=4, k=2)
- **Function (`function/combinations.xs`):** Contains the solution logic using iterative backtracking

## Function Signature

- **Input:**
  - `n` (int): The upper bound of the range [1, n] (must be >= 1)
  - `k` (int): The number of elements to choose (must be >= 0 and <= n)
- **Output:** 
  - Array of int[]: All possible combinations, where each combination is an array of k integers

## Test Cases

| Input (n, k) | Expected Output |
|--------------|-----------------|
| n=4, k=2 | [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]] |
| n=1, k=1 | [[1]] |
| n=5, k=0 | [[]] (empty combination) |
| n=5, k=5 | [[1,2,3,4,5]] |
| n=3, k=2 | [[1,2], [1,3], [2,3]] |

### Notes on Test Cases

- **Basic case:** n=4, k=2 produces C(4,2) = 6 combinations
- **Edge case (single element):** n=1, k=1 produces exactly one combination
- **Edge case (k=0):** Choosing 0 elements from any n produces one combination: the empty set
- **Edge case (k=n):** Choosing all elements produces exactly one combination
- **Small case:** n=3, k=2 demonstrates the backtracking behavior

## Algorithm

The solution uses an **iterative backtracking approach** with an explicit stack to avoid recursion:

1. Validate that k <= n
2. Use a stack to track the current state (start position and depth)
3. For each frame, if we've selected k elements, add the current combination to results
4. Otherwise, push candidates onto the stack in reverse order
5. Continue until the stack is empty

This approach efficiently generates all C(n,k) combinations without recursion depth limitations.
