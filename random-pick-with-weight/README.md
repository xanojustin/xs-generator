# Random Pick with Weight

## Problem

You are given a **0-indexed** array of positive integers `w` where `w[i]` represents the **weight** of index `i`.

You need to implement a function that picks an index randomly based on these weights. The probability of picking index `i` should be proportional to `w[i]` / `sum(w)`.

For example, if `weights = [1, 3, 4, 2]`:
- Total weight = 1 + 3 + 4 + 2 = 10
- Probability of picking index 0 = 1/10 = 10%
- Probability of picking index 1 = 3/10 = 30%
- Probability of picking index 2 = 4/10 = 40%
- Probability of picking index 3 = 2/10 = 20%

## Approach

This solution uses **prefix sums** combined with **binary search**:

1. **Build prefix sums:** Convert weights to cumulative sums
   - For `[1, 3, 4, 2]`, prefix sums = `[1, 4, 8, 10]`
   
2. **Generate random target:** Pick a random number between 1 and total sum
   
3. **Binary search:** Find the first prefix sum that is >= the random target
   - This gives us the index where the random target "falls"

**Time Complexity:** O(n) for prefix sum construction, O(log n) per pick  
**Space Complexity:** O(n) for prefix sum storage

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/random_pick_with_weight.xs`):** Contains the solution logic using prefix sums and binary search

## Function Signature
- **Input:** 
  - `weights` (int[]): Array of positive integers representing weights
  - `num_picks` (int): Number of random picks to perform (default: 1)
- **Output:** 
  - (int[]): Array of picked indices (one per pick requested)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `weights: [1], num_picks: 5` | `[0, 0, 0, 0, 0]` (only one possible index) |
| `weights: [1, 3], num_picks: 1` | Either `0` (25%) or `1` (75%) |
| `weights: [3, 3, 3], num_picks: 3` | Any combination of 0, 1, 2 with equal probability |
| `weights: [1, 3, 4, 2], num_picks: 10` | Distribution roughly: 10% 0s, 30% 1s, 40% 2s, 20% 3s |

### Test Case Descriptions

1. **Single weight:** Only one possible outcome
2. **Two weights:** Tests weighted probability (1:3 ratio)
3. **Equal weights:** Tests uniform distribution
4. **Multiple weighted picks:** Tests distribution over many picks

## Why This Works

The prefix sum array divides the range `[1, total_sum]` into segments where each segment's length equals the corresponding weight. A uniform random number in this range will fall into each segment with probability proportional to the segment length (weight).

```
Weights: [1, 3, 4, 2]
Total: 10

Prefix sums: [1, 4, 8, 10]

Range mapping:
- Index 0: random in [1, 1]   → 1 number  → 1/10 probability
- Index 1: random in [2, 4]   → 3 numbers → 3/10 probability
- Index 2: random in [5, 8]   → 4 numbers → 4/10 probability
- Index 3: random in [9, 10]  → 2 numbers → 2/10 probability
```
