# Largest Number

## Problem
Given an array of non-negative integers, arrange them such that they form the largest possible number when concatenated together.

For example:
- Input: `[3, 30, 34, 5, 9]` → Output: `"9534330"`
- Input: `[10, 2]` → Output: `"210"`

The result may be very large, so return it as a string.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/largest_number.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `numbers` (int[]): An array of non-negative integers
- **Output:** 
  - `text`: The largest possible number formed by concatenating the integers, returned as a string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[3, 30, 34, 5, 9]` | `"9534330"` |
| `[10, 2]` | `"210"` |
| `[1]` | `"1"` |
| `[]` | `"0"` |
| `[0, 0, 0]` | `"0"` |
| `[824, 938, 1399, 5607, 6973, 5703, 9609, 4398, 8247]` | `"9609938824824769735703560743981399"` |

### Test Case Descriptions
1. **Basic case:** Mixed numbers requiring custom sorting
2. **Two numbers:** Shows that "2"+"10" ("210") > "10"+"2" ("102")
3. **Single element:** Edge case with one number
4. **Empty array:** Edge case - returns "0"
5. **All zeros:** Special case where the result should be "0" not "000"
6. **Large numbers:** Tests with larger integers
