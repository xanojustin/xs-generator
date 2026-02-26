# Shuffle the Array

## Problem
Given an array `nums` consisting of `2n` elements in the form `[x1, x2, ..., xn, y1, y2, ..., yn]`, return the array in the form `[x1, y1, x2, y2, ..., xn, yn]`.

In other words, interleave elements from the first half of the array with elements from the second half, taking elements in order from each half.

### Example
- Input: `nums = [2, 5, 1, 3, 4, 7]`, `n = 3`
- First half: `[2, 5, 1]` (x1=2, x2=5, x3=1)
- Second half: `[3, 4, 7]` (y1=3, y2=4, y3=7)
- Output: `[2, 3, 5, 4, 1, 7]` (interleaved: x1, y1, x2, y2, x3, y3)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shuffle_array.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): Array of 2n integers to shuffle
  - `n` (int): Half the length of the array (number of element pairs)
- **Output:**
  - int[]: The shuffled array with interleaved elements

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums = [2, 5, 1, 3, 4, 7], n = 3` | `[2, 3, 5, 4, 1, 7]` |
| `nums = [1, 2, 3, 4, 4, 3, 2, 1], n = 4` | `[1, 4, 2, 3, 3, 2, 4, 1]` |
| `nums = [1, 1, 2, 2], n = 2` | `[1, 2, 1, 2]` |
| `nums = [1, 2], n = 1` | `[1, 2]` |

### Test Case Explanations

1. **Basic case:** `[2, 5, 1, 3, 4, 7]` with `n = 3` → First half `[2, 5, 1]`, second half `[3, 4, 7]` → Interleaved `[2, 3, 5, 4, 1, 7]`

2. **Symmetrical array:** `[1, 2, 3, 4, 4, 3, 2, 1]` with `n = 4` → Creates an interesting palindrome-like pattern when shuffled

3. **Duplicate elements:** `[1, 1, 2, 2]` with `n = 2` → Tests that the algorithm correctly pairs elements even with duplicates

4. **Edge case (minimum size):** `[1, 2]` with `n = 1` → Smallest valid input (2 elements)

## Algorithm

The solution uses a while loop to iterate `n` times:
1. For each index `i` from 0 to n-1:
   - Take element at position `i` from the first half (xi)
   - Take element at position `n + i` from the second half (yi)
   - Append both elements to the result array in order
2. Return the interleaved result array

**Time Complexity:** O(n) - We iterate n times, performing constant work each iteration
**Space Complexity:** O(n) - We create a new array of size 2n to store the result
