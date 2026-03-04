# Count Number of Teams

## Problem

There are `n` soldiers standing in a line. Each soldier is assigned a unique **rating** value.

You have to form a team of 3 soldiers amongst them under the following rules:
- Choose 3 soldiers with indices `(i, j, k)` such that:
  - `0 <= i < j < k < n`
  - **Increasing team:** `rating[i] < rating[j] < rating[k]`
  - **OR Decreasing team:** `rating[i] > rating[j] > rating[k]`

Return the number of teams you can form given these conditions.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_number_of_teams.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `ratings` (`int[]`): An array of unique integers representing soldier ratings
  
- **Output:** 
  - Returns `int`: The total number of valid teams (increasing + decreasing)

## Algorithm

The solution uses an efficient O(n²) approach by considering each soldier as the middle member (j) of a potential team:

1. For each soldier at position `j`:
   - Count soldiers to the **left** with smaller ratings (`left_smaller`)
   - Count soldiers to the **left** with larger ratings (`left_larger`)
   - Count soldiers to the **right** with smaller ratings (`right_smaller`)
   - Count soldiers to the **right** with larger ratings (`right_larger`)

2. Calculate teams with `j` as middle:
   - **Increasing teams:** `left_smaller × right_larger`
   - **Decreasing teams:** `left_larger × right_smaller`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 5, 3, 4, 1]` | `3` | Teams: (2,3,4), (2,5,3) is invalid, (5,3,1), (5,4,1), (3,4,?) → 3 total: (2,3,4), (5,3,1), (5,4,1) |
| `[1, 2, 3, 4]` | `4` | All increasing: (1,2,3), (1,2,4), (1,3,4), (2,3,4) |
| `[4, 3, 2, 1]` | `4` | All decreasing: (4,3,2), (4,3,1), (4,2,1), (3,2,1) |
| `[1]` | `0` | Edge case: not enough soldiers to form a team |
| `[1, 2]` | `0` | Edge case: need at least 3 soldiers |
| `[2, 1, 3]` | `0` | No valid increasing or decreasing triplet |

## Example Walkthrough

For `ratings = [2, 5, 3, 4, 1]`:

- **j=1 (rating=5):** left=[2], right=[3,4,1]
  - left_smaller=1, left_larger=0
  - right_smaller=2 (3,1), right_larger=1 (4)
  - Teams: 1×1 + 0×2 = 1 decreasing: (5,3,1)

- **j=2 (rating=3):** left=[2,5], right=[4,1]
  - left_smaller=1 (2), left_larger=1 (5)
  - right_smaller=1 (1), right_larger=1 (4)
  - Teams: 1×1 + 1×1 = 2 → (2,3,4) increasing, (5,3,1) decreasing

- **j=3 (rating=4):** left=[2,5,3], right=[1]
  - left_smaller=2 (2,3), left_larger=1 (5)
  - right_smaller=1 (1), right_larger=0
  - Teams: 2×0 + 1×1 = 1 decreasing: (5,4,1)

**Total: 3 teams**
