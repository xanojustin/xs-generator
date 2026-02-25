# H-Index

## Problem
Given an array of integers `citations` where `citations[i]` is the number of citations a researcher received for their ith paper, return the researcher's h-index.

According to the definition of h-index on Wikipedia: The h-index is defined as the maximum value of h such that the given researcher has published at least h papers that have each been cited at least h times.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/h_index.xs`):** Contains the solution logic

## Function Signature
- **Input:** `citations` (int[]) - An array of integers where each integer represents the number of citations for a paper
- **Output:** `h_index` (int) - The calculated h-index value

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[3, 0, 6, 1, 5]` | `3` |
| `[1, 3, 1]` | `1` |
| `[]` | `0` |
| `[100]` | `1` |
| `[0, 0, 0]` | `0` |

### Explanation of Test Cases

1. **Basic case:** `[3, 0, 6, 1, 5]` → `3`
   - The researcher has 3 papers with at least 3 citations each (the papers with 3, 6, and 5 citations)
   - The remaining 2 papers have no more than 3 citations each
   - Therefore, h-index = 3

2. **Simple case:** `[1, 3, 1]` → `1`
   - Only 1 paper has at least 1 citation (all papers have at least 1)
   - But only 1 paper has at least 2+ citations (the one with 3)
   - So the maximum h where h papers have at least h citations is 1

3. **Edge case - empty:** `[]` → `0`
   - No papers published, so h-index is 0

4. **Edge case - single high citation:** `[100]` → `1`
   - Only 1 paper exists, so maximum possible h-index is 1

5. **Edge case - all zeros:** `[0, 0, 0]` → `0`
   - No papers have any citations, so h-index is 0

## Algorithm

1. Sort the citations array in descending order
2. Iterate through the sorted array
3. For each position `i` (0-indexed), check if `citations[i] >= i + 1`
4. The h-index is the largest `i + 1` where this condition holds true
