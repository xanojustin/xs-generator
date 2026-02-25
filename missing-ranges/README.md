# Missing Ranges

## Problem
Given a **sorted unique** array of integers `nums` and two integers `lower` and `upper`, return the smallest sorted list of ranges that cover every missing number exactly. That is, no element of `nums` is in any of the ranges, and each missing number is in one of the ranges.

Each range should be formatted as:
- `"a"` if the range contains only one number
- `"a->b"` if the range contains multiple numbers (a to b inclusive)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/missing_ranges.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): Sorted unique array of integers
  - `lower` (int): Lower bound of the range (inclusive)
  - `upper` (int): Upper bound of the range (inclusive)
- **Output:**
  - Array of text strings representing missing ranges

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [0, 1, 3, 50, 75], lower: 0, upper: 99` | `["2", "4->49", "51->74", "76->99"]` |
| `nums: [], lower: 1, upper: 1` | `["1"]` |
| `nums: [], lower: -3, upper: -1` | `["-3->-1"]` |
| `nums: [-1], lower: -1, upper: -1` | `[]` |
| `nums: [-1], lower: -2, upper: -1` | `["-2"]` |

### Test Case Explanations

1. **Basic case:** Numbers 0 and 1 are present, so "2" is missing. Between 1 and 3, "4->49" fills the gap. Between 3 and 50, "51->74" fills the gap. Between 50 and 75, "76->99" fills the gap to upper bound.

2. **Empty array with single value:** No numbers in array, so the entire range [1, 1] is missing.

3. **Empty array with negative range:** Entire range of negative numbers is missing.

4. **No missing numbers:** The single element -1 covers the entire range [-1, -1].

5. **Single missing number:** Only -2 is missing from the range [-2, -1].

## Algorithm

The solution uses a single-pass approach with O(n) time complexity:

1. Initialize `prev` to `lower - 1` to handle the gap before the first element
2. Iterate through the array plus a sentinel value (`upper + 1`)
3. For each position, compare current value with `prev`
4. If the gap is 2 or more, a missing range exists
5. Format the range as single number or "a->b" format
6. Update `prev` to current and continue

The sentinel value ensures we check for missing numbers after the last array element.
