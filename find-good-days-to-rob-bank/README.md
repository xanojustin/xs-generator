# Find Good Days to Rob the Bank

## Problem

The security systems at a bank consist of `n` security devices arranged linearly. For each day `i`, `security[i]` represents the number of guards on duty.

A day `i` is a **good day** to rob the bank if all the following conditions are met:

1. There are at least `time` days before day `i` (i.e., `i - time >= 0`)
2. There are at least `time` days after day `i` (i.e., `i + time < n`)
3. For each of the `time` days before day `i`, the number of guards is **non-increasing** (each day has `<=` guards than the previous)
4. For each of the `time` days after day `i`, the number of guards is **non-decreasing** (each day has `>=` guards than the previous)

Return a list of all good days to rob the bank in ascending order.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/good_days.xs`):** Contains the solution logic for finding good days

## Function Signature

- **Input:**
  - `security` (int[]): Array of guard counts for each day
  - `time` (int): Number of days to check before and after each potential day
  
- **Output:**
  - Returns (int[]): Array of indices representing good days to rob the bank

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `security = [5, 3, 3, 3, 5, 6, 2]`, `time = 2` | `[2, 3]` |
| `security = [1, 2, 3, 4, 5, 6]`, `time = 2` | `[]` |
| `security = [1, 1, 1, 1, 1]`, `time = 0` | `[0, 1, 2, 3, 4]` |
| `security = [1, 2, 3]`, `time = 2` | `[]` (array too small) |
| `security = [5, 4, 3, 2, 3, 4, 5]`, `time = 1` | `[3]` |

### Test Case Explanations

1. **Basic case:** Days 2 and 3 are good days because guards decrease before and increase after
2. **No good days:** Guards are always increasing, so no day has decreasing pattern before it
3. **All days good:** With `time = 0`, there are no constraints, so all days qualify
4. **Edge case:** Array is too small to have `time` days before AND after any day
5. **Peak pattern:** Day 3 is the valley (lowest point) with decreasing before and increasing after
