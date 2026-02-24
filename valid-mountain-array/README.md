# Valid Mountain Array

## Problem

Given an array of integers, determine if it is a **valid mountain array**.

An array is a valid mountain array if and only if:
- It has at least 3 elements
- There exists some index `i` (0 < i < arr.length - 1) such that:
  - `arr[0] < arr[1] < ... < arr[i-1] < arr[i]` (strictly increasing to the peak)
  - `arr[i] > arr[i+1] > ... > arr[arr.length-1]` (strictly decreasing from the peak)

The peak element cannot be the first or last element.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid-mountain-array.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `arr` (int[]): Array of integers to validate
- **Output:**
  - `bool`: `true` if the array forms a valid mountain, `false` otherwise

## Algorithm

1. **Early return:** If array has fewer than 3 elements, return `false`
2. **Walk up:** Iterate from the start while elements are strictly increasing
3. **Check peak:** Peak must not be at index 0 or at the last index
4. **Walk down:** Continue iterating while elements are strictly decreasing
5. **Validate:** Return `true` only if we reached the end of the array

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[2, 1]` | `false` | Too few elements |
| `[3, 5, 5]` | `false` | Plateau at peak (not strictly increasing/decreasing) |
| `[0, 3, 2, 1]` | `true` | Valid mountain with peak at index 1 |
| `[0, 2, 3, 4, 5, 2, 1, 0]` | `true` | Longer valid mountain with peak at index 4 |
| `[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]` | `false` | Only increasing (no descent) |
| `[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]` | `false` | Only decreasing (no ascent) |
| `[1, 7, 9, 5, 4, 2, 1]` | `true` | Valid mountain with multiple descent steps |

### Test Case Descriptions

1. **Edge case (too short):** Array with less than 3 elements cannot form a mountain
2. **Edge case (plateau):** Equal adjacent elements break strict increase/decrease requirement
3. **Basic valid case:** Simple mountain pattern
4. **Longer valid case:** Extended mountain with gradual slopes
5. **Invalid (only up):** Monotonically increasing arrays are not valid mountains
6. **Invalid (only down):** Monotonically decreasing arrays are not valid mountains
7. **Valid complex case:** Mountain with varying slope steepness
