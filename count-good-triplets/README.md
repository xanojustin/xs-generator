# Count Good Triplets

## Problem

Given an array of integers `arr`, and three integers `a`, `b`, and `c`. Return the number of good triplets.

A triplet `(arr[i], arr[j], arr[k])` is **good** if the following conditions are true:
- `0 <= i < j < k < arr.length`
- `|arr[i] - arr[j]| <= a`
- `|arr[j] - arr[k]| <= b`
- `|arr[i] - arr[k]| <= c`

Where `|x|` denotes the absolute value of x.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_good_triplets.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `arr: int[]` - Array of integers to search for good triplets
  - `a: int` - Maximum allowed absolute difference between `arr[i]` and `arr[j]`
  - `b: int` - Maximum allowed absolute difference between `arr[j]` and `arr[k]`
  - `c: int` - Maximum allowed absolute difference between `arr[i]` and `arr[k]`

- **Output:**
  - `int` - The count of good triplets that satisfy all three conditions

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `arr=[3,0,1,1,9,7], a=7, b=2, c=3` | `4` |
| `arr=[1,1,1,1], a=0, b=0, c=0` | `4` |
| `arr=[1,1,1], a=0, b=0, c=0` | `1` |
| `arr=[], a=1, b=1, c=1` | `0` |
| `arr=[1,2], a=1, b=1, c=1` | `0` |

### Test Case Explanations

1. **Basic case:** `[3,0,1,1,9,7]` with `a=7, b=2, c=3` → 4 good triplets: `(0,1,2)`, `(0,1,3)`, `(0,2,3)`, `(1,2,3)`
2. **All same values:** `[1,1,1,1]` with all zeros → 4 triplets (any 3 indices work since differences are all 0)
3. **Minimum valid array:** `[1,1,1]` with all zeros → 1 triplet (only one combination of 3 elements)
4. **Empty array:** `[]` → 0 triplets (not enough elements)
5. **Too few elements:** `[1,2]` → 0 triplets (need at least 3 elements)
