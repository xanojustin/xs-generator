# Russian Doll Envelopes

## Problem

You are given a 2D array of integers `envelopes` where `envelopes[i] = [wi, hi]` represents the width and height of an envelope.

One envelope can fit into another if and only if **both** the width and height of one envelope are greater than the other envelope's width and height.

Return the **maximum number of envelopes** you can Russian doll (i.e., put one inside the other).

**Note:** An envelope cannot be rotated.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_russian_dolls.xs`):** Contains the solution logic using LIS (Longest Increasing Subsequence) algorithm

## Algorithm

The solution uses a classic dynamic programming approach:

1. **Sort envelopes** by width ascending (using bubble sort since XanoScript doesn't have a built-in sort statement)
2. **Find LIS on heights** using the patience sorting / binary search approach for O(n log n) complexity:
   - Maintain `tails` array where `tails[i]` = smallest ending height of an increasing subsequence of length `i+1`
   - Use binary search to find the correct position for each height
   - The length of `tails` is the answer

## Function Signature

- **Input:** `envelopes` - A JSON array of arrays, where each inner array contains two integers `[width, height]`
- **Output:** Integer representing the maximum number of envelopes that can be nested

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[[5,4],[6,4],[6,7],[2,3]]` | `3` | Basic case: [2,3] → [5,4] → [6,7] |
| `[[1,1],[1,1],[1,1]]` | `1` | All same dimensions - can only use one |
| `[]` | `0` | Empty input edge case |
| `[[1,3],[3,5],[6,7],[6,8],[2,3]]` | `3` | Envelopes with same width should not nest |

### Explanation of Test Cases

1. **Basic case:** With envelopes `[5,4], [6,4], [6,7], [2,3]`, we can nest: `[2,3]` → `[5,4]` → `[6,7]` for a total of 3 envelopes.

2. **Same dimensions:** When all envelopes have the same width and height, only one can be used since strict inequality is required.

3. **Empty input:** Returns 0 when no envelopes are provided.

4. **Same width handling:** Envelopes with the same width cannot nest, even if heights differ. The algorithm handles this by sorting and then finding LIS on heights.

## XanoScript Notes

This exercise demonstrates:
- Using `json` input type for flexible array structures
- Manual sorting implementation (since `sort` filter has limited syntax support)
- Binary search implementation using `while` loops
- Array manipulation with `array.push`, `array.merge`, and slice filters
- Avoiding reserved variable names like `$env`
