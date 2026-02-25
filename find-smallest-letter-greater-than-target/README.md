# Find Smallest Letter Greater Than Target

## Problem

Given a sorted array of lowercase letters (each letter appears at least once) and a target letter, find the smallest letter in the array that is larger than the target.

**Important:** Letters wrap around. If the target is greater than or equal to all letters in the array, return the first letter in the array.

### Examples
- `letters = ["c", "f", "j"]`, `target = "a"` → `"c"` (first letter greater than 'a')
- `letters = ["c", "f", "j"]`, `target = "c"` → `"f"` (first letter greater than 'c')
- `letters = ["c", "f", "j"]`, `target = "d"` → `"f"` (first letter greater than 'd')
- `letters = ["c", "f", "j"]`, `target = "j"` → `"c"` (wrap around - 'j' is >= all letters)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_smallest_letter_greater_than_target.xs`):** Contains the binary search solution logic

## Function Signature

- **Input:**
  - `letters` (text[]): Sorted array of lowercase letters in ascending order
  - `target` (text): The target letter to find the next greater letter for
- **Output:** (text) The smallest letter greater than the target, or the first letter if target >= all letters

## Algorithm

This solution uses **binary search** for O(log n) time complexity:

1. Initialize `left = 0` and `right = n - 1` (array boundaries)
2. While `left <= right`:
   - Calculate `mid = left + (right - left) / 2`
   - If `letters[mid] > target`: search left half (`right = mid - 1`)
   - Else: search right half (`left = mid + 1`)
3. After the loop, `left` points to the first letter > target
4. If `left < n`, return `letters[left]`; else wrap around and return `letters[0]`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `letters: ["c", "f", "j"]`, `target: "a"` | `"c"` | 'c' is the first letter > 'a' |
| `letters: ["c", "f", "j"]`, `target: "c"` | `"f"` | 'f' is the first letter > 'c' |
| `letters: ["c", "f", "j"]`, `target: "d"` | `"f"` | 'f' is the first letter > 'd' |
| `letters: ["c", "f", "j"]`, `target: "j"` | `"c"` | Wrap around - 'j' >= all letters |
| `letters: ["a", "b"]`, `target: "z"` | `"a"` | Wrap around - 'z' > all letters |
| `letters: ["e", "e", "e", "k", "q", "q", "q", "v", "v", "y"]`, `target: "q"` | `"v"` | First letter > 'q' is 'v' |
