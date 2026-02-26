# Last Stone Weight

## Problem
You have a collection of stones, each with a positive integer weight. In each turn, we choose the two heaviest stones and smash them together.

Suppose the stones have weights `x` and `y` with `x <= y`. The result of this smash is:
- If `x == y`, both stones are destroyed
- If `x != y`, the stone of weight `x` is destroyed, and the stone of weight `y` has new weight `y - x`

At the end, there is at most 1 stone left. Return the weight of this stone (or 0 if there are no stones left).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/last_stone_weight.xs`):** Contains the solution logic

## Function Signature
- **Input:** `stones` (int[]) - Array of positive integers representing stone weights
- **Output:** `int` - Weight of the last remaining stone, or 0 if no stones remain

## Example
```
Input: stones = [2, 7, 4, 1, 8, 1]

Step 1: Combine 7 and 8 → [2, 4, 1, 1, 1] (8-7=1)
Step 2: Combine 2 and 4 → [1, 1, 1, 2] (4-2=2)
Step 3: Combine 2 and 2 → [1, 1] (destroyed)
Step 4: Combine 1 and 1 → [] (destroyed)
Output: 0
```

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 7, 4, 1, 8, 1]` | `1` | 8-7=1, 4-2=2, 2-1=1, 1-1=0, last is 1 |
| `[1]` | `1` | Single stone, no smash needed |
| `[]` | `0` | Empty array, no stones |
| `[2, 2]` | `0` | Equal stones destroy each other |
| `[10, 5, 2]` | `3` | 10-5=5, 5-2=3 |
| `[31, 26, 33, 21, 40]` | `5` | Multiple smashes result in 5 |

## Algorithm
This solution simulates a max-heap by repeatedly finding and removing the two largest elements, then either discarding both (if equal) or adding their difference back to the collection. The process continues until at most one stone remains.

**Time Complexity:** O(n²) - Finding max twice per iteration  
**Space Complexity:** O(n) - For the heap array

## Notes
- This is a classic heap/priority queue problem
- In production, a proper max-heap data structure would be more efficient
- The XanoScript implementation demonstrates array manipulation, loops, and conditionals
