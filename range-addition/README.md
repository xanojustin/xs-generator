# Range Addition

## Problem

You are given an integer `length` and an array `updates` where each `updates[i] = [startIdx, endIdx, inc]`.

You have an array `arr` of length `length` (all zeros initially). For each update, add `inc` to each element in `arr` from index `startIdx` to `endIdx` (inclusive).

Return the resulting array after applying all updates.

This problem demonstrates the **difference array** technique for efficient range updates.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/range_addition.xs`):** Contains the solution logic using difference array technique

## Function Signature

- **Input:**
  - `length` (int) - The length of the array
  - `updates` (json) - Array of updates, each update is `[startIdx, endIdx, inc]`
- **Output:** `final_array` (json) - The resulting array after applying all updates

## Algorithm

The solution uses the **difference array** technique for O(n + k) time complexity where n is the array length and k is the number of updates:

1. **Initialize difference array** with zeros
2. **Apply each update** to the difference array:
   - Add `inc` at `startIdx` position
   - Subtract `inc` at `endIdx + 1` position (if within bounds)
3. **Compute prefix sum** to get the final values

This avoids O(n × k) brute force by tracking only the boundaries of changes.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `length=5, updates=[[1,3,2],[2,4,3],[0,2,-1]]` | `[-1,1,4,4,3]` | See step-by-step below |
| `length=3, updates=[]` | `[0,0,0]` | No updates, all zeros |
| `length=1, updates=[[0,0,5]]` | `[5]` | Single element update |
| `length=4, updates=[[0,3,1]]` | `[1,1,1,1]` | Full range update |

### Step-by-step for first test case:
- Initial: `[0, 0, 0, 0, 0]`
- After `[1,3,2]`: Add 2 at index 1, subtract 2 at index 4 → `[0, 2, 0, 0, -2]`
- After `[2,4,3]`: Add 3 at index 2, subtract 3 at index 5 (out of bounds) → `[0, 2, 3, 0, -2]`
- After `[0,2,-1]`: Subtract 1 at index 0, add 1 at index 3 → `[-1, 2, 3, 1, -2]`
- Prefix sum: `[-1, 1, 4, 5, 3]`

Wait, let me recalculate:
- Diff after all: `[-1, 2, 3, 1, -2]`
- Prefix: `-1, -1+2=1, 1+3=4, 4+1=5, 5-2=3`
- Result: `[-1, 1, 4, 5, 3]`

Actually: Let me trace through again:
- Start: `[0, 0, 0, 0, 0]`
- Update [1,3,2]: diff[1]+=2, diff[4]-=2 → `[0, 2, 0, 0, -2]`
- Update [2,4,3]: diff[2]+=3, diff[5] out of bounds → `[0, 2, 3, 0, -2]`
- Update [0,2,-1]: diff[0]-=1, diff[3]+=1 → `[-1, 2, 3, 1, -2]`
- Prefix sum: `[-1, 1, 4, 5, 3]`

## Files

- `run.xs` - Run job entry point with test case
- `function/range_addition.xs` - Solution implementation
