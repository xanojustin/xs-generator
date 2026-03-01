# Arranging Coins

## Problem
You have a total of `n` coins that you want to form in a staircase shape, where every k-th row must have exactly k coins.

Given `n`, find the total number of **full** staircase rows that can be formed.

### Example

**n = 5:**
```
¤
¤ ¤
¤ ¤
```
The coins can form 2 complete rows (row 1 has 1 coin, row 2 has 2 coins). The 3rd row would need 3 coins but only 2 remain, so we return **2**.

**n = 8:**
```
¤
¤ ¤
¤ ¤ ¤
¤
```
The coins can form 3 complete rows. The 4th row would need 4 coins but only 2 remain, so we return **3**.

### Mathematical Background

The k-th complete row requires k coins. The total coins needed for k complete rows is the sum of 1 to k:
```
1 + 2 + 3 + ... + k = k * (k + 1) / 2
```

We need to find the maximum k such that `k * (k + 1) / 2 <= n`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/arranging_coins.xs`):** Contains the binary search solution logic

## Function Signature
- **Input:** 
  - `n` (int, non-negative): Total number of coins available
- **Output:** 
  - (int): Number of complete staircase rows that can be formed

## Solution Approach

This solution uses **binary search** to efficiently find the answer:

1. We know k must be between 0 and n (in the worst case, we can form 1 row per coin)
2. For each midpoint `mid`, calculate `coins_needed = mid * (mid + 1) / 2`
3. If `coins_needed == n`, we found the exact answer
4. If `coins_needed < n`, we can potentially form more rows, so search higher
5. If `coins_needed > n`, we need fewer rows, so search lower

Binary search gives us O(log n) time complexity, much faster than the naive linear approach.

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 5 | 2 | Rows: 1+2=3 coins used, row 3 needs 3 more but only 2 remain |
| 8 | 3 | Rows: 1+2+3=6 coins used, row 4 needs 4 more but only 2 remain |
| 0 | 0 | No coins = no rows |
| 1 | 1 | Exactly enough for 1 row |
| 2 | 1 | Row 1 uses 1 coin, row 2 needs 2 more but only 1 remains |
| 3 | 2 | Exactly enough for rows 1 and 2 (1+2=3) |
| 6 | 3 | Exactly enough for rows 1, 2, and 3 (1+2+3=6) |
| 10 | 4 | Exactly enough for rows 1-4 (1+2+3+4=10) |
| 2147483647 | 65535 | Large input test (max int) |

## Edge Cases Handled
- **n = 0:** Returns 0 immediately (no coins, no rows)
- **Exact match:** When coins_needed equals n, we return that exact k value
- **Large inputs:** Binary search handles very large n efficiently
