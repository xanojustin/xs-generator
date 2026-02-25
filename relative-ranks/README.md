# Relative Ranks

## Problem

Given an array of scores, assign ranks to each score. The highest score gets rank 1.

Ranks are assigned as follows:
- 1st place: `"Gold Medal"`
- 2nd place: `"Silver Medal"`
- 3rd place: `"Bronze Medal"`
- 4th place and beyond: The numeric rank as a string (e.g., `"4"`, `"5"`, etc.)

The returned array should have ranks in the same order as the original input scores.

## Example

Input: `[5, 4, 3, 2, 1]`

Output: `["Gold Medal", "Silver Medal", "Bronze Medal", "4", "5"]`

Explanation: 
- Score 5 is highest → rank 1 → "Gold Medal"
- Score 4 is second → rank 2 → "Silver Medal"
- Score 3 is third → rank 3 → "Bronze Medal"
- Score 2 is fourth → rank 4 → "4"
- Score 1 is fifth → rank 5 → "5"

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `[5, 4, 3, 2, 1]`
- **Function (`function/relative_ranks.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `scores` (int[]): Array of integer scores
  
- **Output:** 
  - `text[]`: Array of rank strings in the same order as input scores

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[5, 4, 3, 2, 1]` | `["Gold Medal", "Silver Medal", "Bronze Medal", "4", "5"]` |
| `[10, 3, 8, 9, 4]` | `["Gold Medal", "5", "Bronze Medal", "Silver Medal", "4"]` |
| `[100]` | `["Gold Medal"]` |
| `[]` | `[]` |
| `[50, 50, 50]` | `["Gold Medal", "Silver Medal", "Bronze Medal"]` |

### Test Case Explanations

1. **Basic case:** Standard descending scores
2. **Unordered case:** Scores not in order; ranks should be based on relative values
3. **Single element:** Edge case with just one score
4. **Empty array:** Edge case with no scores
5. **Tie case:** When scores are equal, earlier in sorted array gets better rank
