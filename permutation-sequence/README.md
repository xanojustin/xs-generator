# Permutation Sequence

## Problem
Given two integers `n` and `k`, return the kth permutation sequence of numbers `[1, 2, ..., n]`.

The set `[1, 2, ..., n]` contains a total of `n!` unique permutations. By listing and labeling all of the permutations in order, we can determine the kth permutation without generating all permutations.

### Example
- For `n = 3`, the permutations in order are: `"123", "132", "213", "231", "312", "321"`
- The 3rd permutation (`k = 3`) is `"213"`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/permutation_sequence.xs`):** Contains the solution logic using the factorial number system

## Function Signature
- **Input:**
  - `n` (int): The range of numbers (1 to n). Must be between 1 and 9.
  - `k` (int): The kth permutation to find (1-indexed). Must be between 1 and n!.
- **Output:** 
  - (text): The kth permutation sequence as a string

## Algorithm
This solution uses the **factorial number system** (factoradic) approach:

1. **Precompute factorials:** Calculate `0!` through `(n-1)!` and store in an array
2. **Create available numbers:** Initialize a list `[1, 2, ..., n]`
3. **Build result iteratively:** For each position from `n` down to `1`:
   - Calculate index = `(k-1) / factorial[position-1]`
   - Select the number at that index from available numbers
   - Append to result string
   - Remove the selected number from available list
   - Update `k = (k-1) % factorial[position-1] + 1`

**Time Complexity:** O(n²) due to list removal operations
**Space Complexity:** O(n) for storing factorials and available numbers

## Test Cases

| n | k | Expected Output | Explanation |
|---|---|-----------------|-------------|
| 3 | 3 | "213" | 3rd permutation of [1,2,3] |
| 4 | 9 | "2314" | 9th permutation of [1,2,3,4] |
| 3 | 1 | "123" | First permutation |
| 1 | 1 | "1" | Single element edge case |
| 9 | 362880 | "987654321" | Last permutation of 9! = 362,880 |

## Constraints
- `1 <= n <= 9`
- `1 <= k <= n!`

## Notes
- The constraint `n <= 9` ensures that `n!` fits within a 32-bit integer
- The algorithm efficiently computes the result without generating all `n!` permutations
